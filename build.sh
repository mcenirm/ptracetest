#!/bin/bash

set -e
set -u


nonroot=alpine-nonroot:3.5-onbuild
nonroot_workdir=/home/nonroot/work

repo_prefix=$( docker info | sed -n -e 's/^Username: \(.*\)$/\1\//p' | head -1 )ptracetest
compiler=${repo_prefix}-compiler:latest
strace=${repo_prefix}-strace:latest
python_ptrace=${repo_prefix}-python-ptrace:latest


function build_docker_image () {
  local build_dir=$1
  local image_name=$2

  ( cd "${build_dir}" && docker build -t "${image_name}" . )
}

function build_wrapper_script () {
  local script_name=$1
  local image_name=$2
  local wrapper=wrapper-${script_name}.sh

  cat > "${wrapper}" <<EOF
#!/bin/bash

set -e
set -u

parent=\$( cd "\$( dirname "\$0" )" && /bin/pwd )
child=\$( /bin/pwd )
child=\${child#\${parent}}
volume=${nonroot_workdir}
workdir=\${volume}\${child}
cmd=(
    docker
    run
    --rm
    -it
    --security-opt seccomp:unconfined
    -v "\${parent}:\${volume}"
    -w "\${workdir}"
    "${image_name}"
)

set -x
"\${cmd[@]}" "\$@"
EOF

  chmod +x "${wrapper}"
}


build_docker_image docker-alpine-nonroot "${nonroot}"

build_docker_image docker-compiler "${compiler}"

docker run --rm -it -v "${PWD}:${nonroot_workdir}" "${compiler}" make CFLAGS=-pthread pthread1

build_docker_image docker-strace "${strace}"
build_wrapper_script strace "${strace}"

build_docker_image docker-python-ptrace "${python_ptrace}"
build_wrapper_script python-ptrace "${python_ptrace}"

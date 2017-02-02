#!/bin/bash

set -e
set -u

repo_prefix=$( docker info | sed -n -e 's/^Username: \(.*\)$/\1\//p' | head -1 )ptracetest
compiler=${repo_prefix}-compiler:latest
strace=${repo_prefix}-strace:latest


function build_docker_image () {
  local build_dir=$1
  local image_name=$2

  ( cd "${build_dir}" && docker build -t "${image_name}" . )
}


build_docker_image docker-compiler "${compiler}"

docker run --rm -it -v "${PWD}:/home/blank/src" "${compiler}" make CFLAGS=-pthread pthread1

build_docker_image docker-strace "${strace}"

cat > wrapper-strace.sh <<EOF
#!/bin/bash

set -e
set -u

parent=\$( cd "\$( dirname "\$0" )" && /bin/pwd )
child=\$( /bin/pwd )
child=\${child#\${parent}}
volume=/home/blank/work
workdir=\${volume}\${child}
cmd=(
    docker
    run
    --rm
    -it
    --security-opt seccomp:unconfined
    -v "\${parent}:\${volume}"
    -w "\${workdir}"
    ${strace}
)

set -x
"\${cmd[@]}" "\$@"
EOF
chmod +x wrapper-strace.sh

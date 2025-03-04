alias drun="docker run -it \
    --ipc=host \
    --network host \
    --privileged \
    --shm-size 16g \
    --device=/dev/kfd \
    --device=/dev/dri \
    --device=/dev/mem \
    --group-add video \
    --cap-add=SYS_PTRACE \
    --cap-add=CAP_SYS_ADMIN \
    --security-opt seccomp=unconfined \
    --security-opt apparmor=unconfined \
    -v ${HOME}:/ws -w /ws \
    "

# /usr/bin/env bash

# VNC with password authentication enabled
# To set a password after starting: ./set-vnc-password.sh <your_password>
qemu-system-x86_64 \
  -enable-kvm \
  -m 4G \
  -smp 4 \
  -cpu host \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/x64/OVMF.4m.fd \
  -drive if=pflash,format=raw,file=ovmf_vars.fd \
  -boot order=c \
  -drive file=./nixos.qcow2,if=virtio,format=qcow2 \
  -display vnc=:1,password=on \
  -monitor unix:/tmp/qemu-monitor.sock,server,nowait \
  -device qxl-vga,vram_size=134217728 \
  -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::3389-:3389 \
  -device qemu-xhci,id=usb \
  -device virtio-net-pci,netdev=net0 \
  -device usb-tablet \
  -fsdev local,security_model=passthrough,id=fsdev0,path=/home/ardfard/qemu-share \
  -device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=host_share \
  -device virtio-serial-pci \
  -chardev socket,id=charchannel0,path=/tmp/qga.sock,server=on,wait=off \
  -device virtserialport,chardev=charchannel0,name=org.qemu.guest_agent.0 \
  -boot menu=on


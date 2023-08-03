# About

Packer manifests to create a plain image (QEMU/LibVirt) for testing

# Build the images (Ubuntu 22.04 based)

Install packer (https://developer.hashicorp.com/packer/downloads)

review the `source` section of the manifests and change to the correct base image

```
source "libvirt" "..." {
  volume {
    source {    
    ...
      urls = [...]        
```

after


```
packer init . && packer build .
```

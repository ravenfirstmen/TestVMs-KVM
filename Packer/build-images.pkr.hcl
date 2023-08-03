
build {

  sources = [
    "source.libvirt.plain"
  ]

  provisioner "shell" {
    inline = [
      "/usr/bin/cloud-init status --wait",
    ]
  }

  provisioner "shell" {
    inline = [
      "echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections",
    ]
  }

  provisioner "shell" {
    scripts = ["./files/packages/00-install-utils.sh"]
  }

  provisioner "shell" {
    scripts = [
      "./files/scripts/99-clean-image.sh"
    ]
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }

}

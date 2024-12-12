# Introduction to autoinstall

Auto-install of Ubuntu, also known as unattended or hands-off installation, allows you to perform an automatic installation without user interaction. For Ubuntu Server (version 20.04 and later) and Ubuntu Desktop (version 23.04 and later), this is done using the autoinstall format[1].

The process works as follows:

1. You create an autoinstall configuration file in YAML format, which contains answers to all installation questions[1].

2. During the installation process, the system uses this configuration file to automatically answer all setup questions without requiring user input[1].

3. If any question is not answered in the configuration file, the installer will use the default option[1].

4. You can designate specific sections of the configuration as "interactive" if you want the installer to stop and ask about those particular items[1].

5. The installation proceeds automatically, with progress and any errors reported via the system[1].

This method differs from the older debian-installer preseeding by using YAML format instead of `debconf-set-selections` and by **defaulting to automatic** answers for any unspecified options[1].

# autoinstall quickstart

This quickstart provides instructions for using autoinstall to set up Ubuntu on an amd64 virtual machine. It offers two methods: network-based installation and installation using a separate volume for autoinstall configuration.

## Network-based Installation

1. Download the latest Ubuntu Server ISO.
2. Mount the ISO to a local directory.
3. Create a cloud-init configuration with autoinstall settings.
4. Serve the configuration over HTTP using Python.
5. Create a target VM disk.
6. Run the installation using KVM, pointing to the HTTP server for configuration.
7. Boot the installed system.

## Installation Using Separate Volume

1. Download the latest Ubuntu Server ISO.
2. Create user-data and meta-data files with autoinstall configuration.
3. Create an ISO to use as a cloud-init data source.
4. Create a target VM disk.
5. Run the installation using KVM, providing the cloud-init ISO and Ubuntu Server ISO.
6. Boot the installed system.

Both methods use a basic autoinstall configuration that sets the hostname to "ubuntu-server" and creates a user named "ubuntu" with the password "ubuntu". The installation is performed using KVM, and the resulting system can be booted and accessed using the created disk image[3].

# How to use ubuntu-image with the classic command

The :command:`classic` command in :command:`ubuntu-image` is used to create classical Ubuntu images based on traditional Ubuntu releases (like Desktop or Server images). The :command:`classic` command uses an **image definition** YAML file to define the image structure.[2]

## Building a basic Ubuntu image for a PC

```yml
# Image metadata
name: ubuntu-classical-amd64
display-name: Ubuntu Classical Image for amd64
revision: 1
architecture: amd64
series: noble
class: preinstalled

# Optional kernel (defaults to 'linux' if omitted)
kernel: linux-image-generic

# Gadget snap
gadget:
  url: https://github.com/canonical/pc-gadget
  branch: classic
  type: git

# Root filesystem definition
rootfs:
  components:
    - main
    - restricted
    - universe
    - multiverse
  archive: ubuntu
  mirror: http://archive.ubuntu.com/ubuntu/
  pocket: updates
  seed:
    urls:
      - git://git.launchpad.net/~ubuntu-core-dev/ubuntu-seeds/+git/
    names:
      - server
      - minimal
    branch: noble
    vcs: true
  sources-list-deb822: true

# Required dependency
customization:
  extra-snaps:
    - name: snapd

# Artifacts to generate
artifacts:
  img:
    - name: ubuntu-classical-amd64.img
  manifest:
    name: ubuntu-classical-amd64.manifest
```

Citations:
[1] https://canonical-subiquity.readthedocs-hosted.com/en/latest/intro-to-autoinstall.html
[2] https://canonical-subiquity.readthedocs-hosted.com/en/latest/howto/ubuntu-image-classic-examples.html
[3] https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/19229998/de41f05d-2158-4867-a0cb-0c13f8bfee0e/paste.txt
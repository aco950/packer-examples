# Instructions for building a CentOS 7 KVM virtual image via Packer

Tested on:

* CentOS Linux release 7.8.2003 (Core)
* CentOS-7-x86_64-Minimal-2003.iso
* packer 1.5.6
* nginx 1.16.1

Pre-requisites:

* KVM
* Packer
* An HTTP directory index configured to serve kickstart files.

Run as follows (add additional flags as needed):

```sh
$ ./run.sh
```

Edit `packer.json` as needed.

Things to keep in mind:

* In `packer.json`, the `pause_before_connecting` directive needs to 
  be set sufficiently long enough for both the OS to be installed and for
  kickstart to do a reboot afterwards into the post-installation
  environment. 

  Since I'm running yum commands inside the shell provisioner (near the 
  end of `packer.json`), the yum commands will only work inside the 
  post-installation environment, not during the chroot/installation 
  environment.

  Setting the `pause_before_connecting` value too low will result in 
  Packer connecting too soon (i.e., to the chroot/installation environment 
  instead of the post-installation environment). The setting that worked 
  for me was "8m", but this may need to be adjusted to account for 
  different environments.

* In `run.sh`, set `$workdir` to match your environment.


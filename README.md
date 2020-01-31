# HashiCrop `packer` Template of Ubuntu 16 (xenial-xerus)
This repo contains a `packer` template for building a Vagrant Base Box of [Ubuntu 16](http://releases.ubuntu.com) (aka xenial-xerus).


### Prerequisites
Ensure that you already have the following applications installed & working:
 - [**Virtualbox**](https://www.virtualbox.org/)
 - [**Virtualbox Guest Additions (VBox GA)**](https://download.virtualbox.org/virtualbox/)
 - > **MacOS** (aka OSX) - VirtualBox 6.x+ is expected to be shipped with the related .iso present under (eg):
 `/Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso`
You may however need to download the .iso specific to your version (mount it) and execute the VBoxDarwinAdditions.pkg
 - [**Vagrant**](https://www.vagrantup.com/)
 - [**Packer**](https://www.packer.io/)


## Usage
Make all changes as required (hostnames, etc.) and thereafter commence with build using `packer` CLI:

```bash
packer validate ubuntu-16.04.2-xenial-xerus.json && \
# if output: Template validated successfully. \
packer build ubuntu-16.04.2-xenial-xerus.json
```

The resulting Vagrant Base **\*.box** file will be produced in the root of the repository (where no issues / errors).

See [vagrantup.com/aphorise/boxes/ubuntu16](https://app.vagrantup.com/aphorise/boxes/ubuntu16) for generated image.

## Notes
Make adjustments to use appropriate mirrors (which are insecure ftp or http presently) where intended to extend to make proper use beyond a mere practise / training.

If your development & delivery resource specifications differ (eg - you'd like to use more resource locally) then update (`ubuntu-16.04.2-xenial-xerus.json`) by adding the below noted **`vboxmanage_post`** block (after: *`vboxmanage`*) within the *`builders`* section as well its related **`variables`**:
```
"variables":
{
    ...
 	"cpu_cores_delivery": "1",
	"memory_delivery": "1024",
    ...
},
"builders":
[{
    ...
	"vboxmanage_post":
	[
		[ "modifyvm", "{{.Name}}", "--memory", "{{user `memory_delivery`}}" ],
		[ "modifyvm", "{{.Name}}", "--cpus", "{{user `cpu_cores_delivery`}}" ]
	],
    ...
}],
```


## Reference & Credits:
Some material re-used from:
 * [nielsabels/packer-xenial64](https://github.com/nielsabels/packer-xenial64)
------

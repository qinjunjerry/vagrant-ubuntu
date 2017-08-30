# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu-16.04-amd64-virtualbox"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  
  # Create multiple VMs + additional hard disks
  # VirutalBoxVMDir = "/Users/jqin/Workspace/VirtualBoxVMs"
  #
  # (1..2).each do |i|
  #   config.vm.define "node#{i}" do |node|
  #     node.vm.hostname = "node#{i}"
  #     node.vm.network "private_network", ip: "192.168.56.1#{i}"
  #
  #     node.vm.provider "virtualbox" do |vb|
  #       vb.name = "node#{i}"
  #     end
  #   end
  # end
  # (1..2).each do |i|
  #   config.vm.define "node#{i}" do |node|
  #     node.vm.provider "virtualbox" do |vb|
  #       ### add additional hard disks
  #       dataDisk1 = "#{VirutalBoxVMDir}/node#{i}/dataDisk1.vdi"
  #       # Building disk files if they don't exist
  #       if not File.exists?(dataDisk1)
  #         vb.customize ['createhd', '--filename', dataDisk1, '--variant', 'Standard', '--size', 10 * 1024]
  #         # Adding a SATA controller that allows 4 hard drives
  #         vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 4]
  #         # Attaching the disks using the SATA controller
  #         vb.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', dataDisk1]
  #       end
  #     end
  #   end
  # end

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true

    # Customize the amount of memory on the VM:
    vb.memory = "4096"

    # Customize the number of CPUs
    vb.cpus = 2

    # Import the base box into a master VM.
    vb.linked_clone = true

  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
  config.vm.provision "bootstrap", type: "shell", preserve_order: true, path: "bootstrap.sh"

  # Provision with Puppet
  config.vm.provision :puppet do |puppet|

    # these are default setttings, uncomment to set differently
    #puppet.manifests_path = "manifests"
    #puppet.manifest_file  = "default.pp"

    # modules: the directory for the modules in this repo
    # external: the directory for the modules downloaded by r10k on demand
    puppet.module_path    = ["modules", "external"]
    puppet.hiera_config_path = "hiera.yaml"

    # needed by puppet 4 or later
    puppet.binary_path    = "/opt/puppetlabs/bin"
    puppet.environment_path = "environments"
    puppet.environment = "production"
    # puppet.options = "--verbose --debug"
  end

end

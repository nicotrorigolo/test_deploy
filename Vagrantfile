Vagrant.configure("2") do |config|
    config.vm.provider :virtualbox do |v|
      v.memory = 8192
      v.cpus = 4
    end

    config.vm.define :test do |test|
      # Vagrant va récupérer une machine de base ubuntu 20.04 (focal) depuis cette plateforme https://app.vagrantup.com/boxes/search
      test.vm.box = "ubuntu/bionic64"
      test.vm.hostname = "test"
      test.vm.network :private_network, ip: "192.168.10.10"
      config.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
      service ssh restart
      SHELL
      config.vm.provision "shell", privileged: false, path: "aaa.sh"
    end
  end

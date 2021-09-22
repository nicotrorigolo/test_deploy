Vagrant.configure("2") do |config|
    # config.vm.provider :virtualbox do |v|
    #   v.memory = 8192
    #   v.cpus = 4
    # end

    config.vm.define :test do |test|
      # Vagrant va récupérer une machine de base ubuntu 20.04 (focal) depuis cette plateforme https://app.vagrantup.com/boxes/search
      test.vm.box = "ubuntu/bionic64"
      test.vm.hostname = "test"
      test.vm.network :private_network, ip: "10.12.0.10"
      test.vm.provider :virtualbox do |v|
        v.memory = 8192
        v.cpus = 4
      end
      test.vm.provision "shell", inline: <<-SHELL
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
      service ssh restart
      SHELL
      test.vm.provision "shell", privileged: false, path: "aaa.sh"
    end
  

# Vagrant.configure('2') do |config|
#   config.ssh.insert_key = false
#   config.vm.provider :virtualbox do |v|
#     v.memory = 1024
#     v.cpus = 1
#   end
  # si le montage du dossier partagé ne fonctionne pas décommentez la ligne suivante
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.define :dockeragent do |dockeragent|
    dockeragent.vm.box = 'ubuntu/focal64'
    dockeragent.vm.hostname = 'dockeragent'
    dockeragent.vm.network :private_network, ip: '10.12.0.11'

    dockeragent.ssh.insert_key = false
    dockeragent.vm.provider :virtualbox do |k|
      k.memory = 1024
      k.cpus = 1
    end

    dockeragent.vm.provision :shell, privileged: false, inline: <<-SHELL
      sudo rm /etc/resolv.conf && echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf && sudo chattr +i /etc/resolv.
      sudo apt update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
      echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      sudo apt-get update
      sudo apt-get install -y docker-ce docker-ce-cli containerd.io
      sudo apt-get install -y openjdk-13-jdk
      sudo -u vagrant mkdir -p /home/vagrant/jenkins_agent
      sudo docker login registry.gitlab.com -u nicorigolo -p bogossdu49$ #chuuut, ne dis rien à personne
    SHELL
  end
end

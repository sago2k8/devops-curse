wget -O packer.zip https://releases.hashicorp.com/packer/1.0.4/packer_1.0.4_linux_amd64.zip?_ga=2.243382213.1575990318.1503506122-355694350.1503506122
unzip packer.zip
./packer validate deployments/template.json
./packer build deployments/template.json

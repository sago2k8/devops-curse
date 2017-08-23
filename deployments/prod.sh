wget -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.0.4/packer_1.0.4_linux_amd64.zip?_ga=2.243382213.1575990318.1503506122-355694350.1503506122
wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.10.2/terraform_0.10.2_linux_amd64.zip?_ga=2.7796338.197602616.1503508734-129106718.1503508734
unzip /tmp/packer.zip -d ~/bin
unzip /tmp/terraform.zip -d ~/bin
packer validate deployments/template.json && packer build deployments/template.json
export TF_VAR_image_id=$(curl -H "Authorization: Bearer $DIGITALOCEAN_API_TOKEN" https://api.digitalocean.com/v2/images?private=true | jq ."images[] | select(.name == \"platzi-demo-$CIRCLE_BUILD_NUM\") | .id")
echo $TF_VAR_image_id
cd infra && terraform apply && cd .. &&
git add infra && git commit -m "Deployed $CIRCLE_BUILD_NUM [skip ci]" &&
git push origin master

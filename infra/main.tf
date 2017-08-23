resource "digitalocean_loadbalancer" "platzi-demo" {
  name = "platzi-http"
  region = "nyc3"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 3000
    target_protocol = "http"
  }

  healthcheck {
    port = 3000
    protocol = "http"
    path = "/"
  }

    droplet_tag = "${digitalocean_tag.platzi-demo.name}"
}

resource "digitalocean_tag" "platzi-demo" {
  name = "platzi-html"
}

resource "digitalocean_droplet" "platzi-demo" {
  image  = "27272280"
  name   = "devops-curse"
  region = "nyc3"
  size   = "512mb"
  ssh_keys = ["5417706"]
  tags   = ["${digitalocean_tag.platzi-demo.id}"]
  user_data = <<EOF
#cloud-config
coreos:
  units:
    - name: "platzi.service"
      command: "start"
      content: |
        [Unit]
        Description=Platzi Demo
        After=docker.service
        Requires=docker.service
        [Service]
        ExecStart=/usr/bin/docker run -d -p 3000:3000 platzi
EOF
}

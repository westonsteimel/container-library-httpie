workflow "Build and deploy on push" {
  on = "push"
  resolves = [
    "Docker Registry",
    "Docker Push"
  ]
}

action "Docker Registry" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Build" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Docker Registry"]
  args = "build -t  $DOCKER_USERNAME/httpie ."
  secrets = ["DOCKER_USERNAME"]
}

action "Docker Tag" {
  uses = "actions/docker/tag@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Docker Build"]
  args = "$DOCKER_USERNAME/httpie $DOCKER_USERNAME/httpie"
  secrets = ["DOCKER_USERNAME"]
}

action "Docker Push" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Docker Tag"]
  args = "push $DOCKER_USERNAME/httpie"
  secrets = ["DOCKER_USERNAME"]
}

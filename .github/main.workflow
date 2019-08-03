workflow "Build and deploy on push" {
  on = "push"
  resolves = [
    "Login DockerHub",
    "Login GitHub Package Registry",
    "Push DockerHub",
    "Push GitHub Package Registry"
  ]
}

action "Login DockerHub" {
  uses = "actions/docker/login@86ff551d26008267bb89ac11198ba7f1d807b699"
  runs = ["./login-dockerhub.sh"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Login GitHub Package Registry" {
  uses = "actions/docker/login@86ff551d26008267bb89ac11198ba7f1d807b699"
  runs = ["./login-gh-pkg-reg.sh"]
  secrets = ["DOCKER_USERNAME", "GH_PKG_REG_PASSWORD", "GH_PKG_REG_URL"]
}

action "Docker Build" {
  uses = "actions/docker/cli@86ff551d26008267bb89ac11198ba7f1d807b699"
  args = "build -t \"${DOCKER_USERNAME}/httpie:latest\" -t \"${GH_PKG_REG_URL}/${DOCKER_USERNAME}/docker-httpie/httpie:latest\" ."
  secrets = ["DOCKER_USERNAME", "GH_PKG_REG_URL"]
  needs = ["Login DockerHub", "Login GitHub Package Registry"]
}

action "Docker Tag" {
  uses = "actions/docker/cli@86ff551d26008267bb89ac11198ba7f1d807b699"
  needs = ["Docker Build"]
  runs = ["./tag.sh"]
  secrets = ["DOCKER_USERNAME"]
}

action "Push DockerHub" {
  uses = "actions/docker/cli@86ff551d26008267bb89ac11198ba7f1d807b699"
  needs = ["Docker Tag"]
  args = "push \"${DOCKER_USERNAME}/httpie\""
  secrets = ["DOCKER_USERNAME"]
}

action "Push GitHub Package Registry" {
  uses = "actions/docker/cli@86ff551d26008267bb89ac11198ba7f1d807b699"
  needs = ["Docker Tag"]
  args = "push \"${GH_PKG_REG_URL}/${DOCKER_USERNAME}/docker-httpie/httpie\""
  secrets = ["DOCKER_USERNAME", "GH_PKG_REG_URL"]
}


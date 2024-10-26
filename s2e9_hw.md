# #s2e9 Бегуны в коробке

## Переводим ранеры в докер

![runner-in-docker](./img/s2e9-runner-in-docker.PNG "runner-in-docker")

![runner-in-docker2](./img/s2e9-runner-in-docker2.PNG "runner-in-docker2")

/srv/gitlab-runner/config/config.toml

```yaml
[runners.docker]
    tls_verify = false
    image = "docker:dind"
    privileged = true
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/home/runner/.ssh:/home/gitlab-runner/.ssh", "/cache"]
    shm_size = 0
    network_mtu = 0
```

[GitLAB devops-pipelines gitlab-ci.yml:](https://gitlab.com/AleksTurbo/devops-pipelines/-/blob/main/pythoner/.gitlab-ci.yml)

![GitLAB-run-pipeline](./img/s2e9-pipeline.PNG "GitLAB-run-pipeline")

![docker-run](./img/s2e9-GitLAB-docker-run.PNG "docker-run")

![web-app](./img/s2e8-GitLAB-web-app.PNG "web-app")

## Links

[GitLAB pythoner REPO:](https://gitlab.com/AleksTurbo/pythoner/)

[GitLAB devops-pipelines ](https://gitlab.com/AleksTurbo/devops-pipelines/)

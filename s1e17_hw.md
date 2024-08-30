# #s1e17 GitLAb Деплой

## Задача 1

## Модернизация PipeLINE

[.gitlab-ci.yml:](./gitlab/.gitlab-ci.yml)

P.S. - нумерацию ранеров поменял, чтобы с предудущими было одинаково:

```yml
- if: '$CI_COMMIT_REF_NAME == "develop"'
      variables:
        RUNNER_TAG: "lf-runner1"
        RUNNER_SHELL_TAG: "lf-runner-shell1"
    - if: '$CI_COMMIT_REF_NAME == "main"'
      variables:
        RUNNER_TAG: "lf-runner2"
        RUNNER_SHELL_TAG: "lf-runner-shell2"
```

## Проверяем работоспособность

![gitlab-pipeline](./img/s1e17-gitlab-pipeline.PNG "gitlab-pipeline")

## registry

![gitlab-registry](./img/s1e17-gitlab-registry.PNG "gitlab-registry")

## Проверяем результат

![stage-docr-ps](./img/s1e17-gitlab-stage-docr-ps.PNG "stage-docr-ps")

![prod-docr-ps](./img/s1e17-gitlab-prod-docr-ps.PNG "prod-docr-ps")

![prod-web](./img/s1e17-gitlab-prod-web.PNG "prod-web")

![stage-web](./img/s1e17-gitlab-stage-web.PNG "stage-web")

## Links

[INFRA repo:](https://github.com/AleksTurbo/infra)

[ansible-roles:](https://github.com/AleksTurbo/ansible-roles)

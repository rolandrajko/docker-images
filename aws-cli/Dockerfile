FROM python:3.8-alpine

ARG AWS_CLI_VERSION=1.25.14

RUN apk add --no-cache \
        bash \
        curl \
        gawk \
        groff \
        jq \
        less \
        mailcap \
    && pip install --no-cache-dir awscli==${AWS_CLI_VERSION} \
    && curl -sSo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest \
    && echo "$(curl -s https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest.md5)  /usr/local/bin/ecs-cli" | md5sum -c - \
    && chmod +x /usr/local/bin/ecs-cli

VOLUME /root/.aws

CMD ["aws", "--version"]

# AWS CLI Docker image

Containerized AWS CLI on Alpine to avoid requiring the AWS CLI to be installed on developer or CI machines.  
The image also provides a few other tools, including [jq](https://stedolan.github.io/jq/) and [ECS CLI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI.html).

## Providing credentials

Credentials can be provided in any of the AWS CLI supported formats.

### Using credentials file

If you need to create the credentials file, you can use the `aws configure` command:

```
docker run --rm -it -v $HOME/.aws:/root/.aws rolandrajko/aws-cli aws configure
```

From that point on, simply mount the directory containing your config.

### Using environment variables

This is supported, although NOT encouraged, as the environment variables can end up in command line history, available for container inspection, etc.

* `AWS_ACCESS_KEY_ID` - AWS Access Key ID
* `AWS_SECRET_ACCESS_KEY` - AWS Secret Access Key
* `AWS_DEFAULT_REGION` - Default region name

```
docker run --rm -e AWS_ACCESS_KEY_ID=my-access-key-id -e AWS_SECRET_ACCESS_KEY=my-secret-access-key -e AWS_DEFAULT_REGION=my-region rolandrajko/aws-cli
```

## Using the container as a CLI command

You can setup an alias for `aws` to simply start a container, hiding the fact that it's not actually installed on the machine.

```
alias aws='docker run --rm -it -v $HOME/.aws:/root/.aws -v $(pwd):/usr/src/app rolandrajko/aws-cli aws'
```

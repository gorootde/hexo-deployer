# hexo-deployer
Docker Image that does automated hexo deployments when started. The image publishes the contents of a given git-url once when it is started.

Usage scenarios:
- Git commit hooks
- Automatic deployment via cronjobs
- ...

Features:
- Clone from arbitrary git repository
- Hides your secrets from git repo
- Takes care of installing optional nmp modules

## Configuration
The configuration options are:
- Environment `GIT_URL`: must point to your git repository containing your hexo site
- Environment variable `SECRET`: The contents of this variable will replace all occurences of the placeholder `@SECRET@` in your `_config.yml`. The variable is optional, and only needed in case you do not want to commit your deployment configuration including the password. An example for a deployment configuration that makes use of `SECRET` is shown below
- If you are using SSH as git protocol, mount your private key to `/root/.ssh/id_rsa`
- To speed up the deployment process you may make the `/repo` directory persistant by using a docker named volume. This is optional. If the repo is not persistent, the image will perform a new git clone every time it is started.

### Example deployment
Example for using deployment configuration without the need to commit your password to git.

```yaml
...
deploy:
  type: sftp
  host: my-hosting.com
  user: hexo
  pass: @SECRET@
...
```


### Example `docker-compose.yml`
```yaml
version: '3.5'
services:
  hexo-deployer:
    container_name: hexodeployer
    image: goroot/hexodeployer
    volumes:
      - /home/user/.ssh/id_rsa:/root/.ssh/id_rsa
      - repo:/repo
    environment:
      - SECRET=password
      - GIT_URL=ssh://git@foo-bar.com:22/mysite.git
volumes:
  repo:

```

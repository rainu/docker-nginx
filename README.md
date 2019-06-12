# docker-nginx

If you only want to add a config-file into the official [nginx docker image](https://hub.docker.com/_/nginx)
you have to make your own Dockerfile and add a such config-file. This annoys me! So i have made this
docker image. Here you can define (config) files inside the environment variables!

The following docker command will create the file:

*/etc/nginx/conf.d/global.conf*
```
client_max_body_size 512M;
client_body_buffer_size 128M;
```

```bash
docker run \
  -e "CFG_0_FILE=/etc/nginx/conf.d/global.conf" \
  -e "CFG_0_CONTENT_0=client_max_body_size 512M;" \
  -e "CFG_0_CONTENT_1=client_body_buffer_size 128M;" \
  rainu/nginx
```

## Documentation

| Variable      | Required | Description  |
| ------------- |:--------:| ------------|
| CFG_*N*_FILE | true | The target file path |
| CFG_*N*_MOD | false | The chmod-mode for the file |
| CFG_*N*_OWNER | false | The chown user and or group (delimited by ":" ) for the file |
| CFG_*N*_CONTENT_M | true | The content of the file. |

You can define multiple files! The file-env-variables is grouped by the **N** inside the variables.
# nginx container

|名称|値|備考|
|:-:|:-:|:-:|
|コンテナ名|nginx||
|ボリューム名|nginx|nginx.volumeで指定|
|port|8080/tcp|HTTP|
|port|8443/tcp|HTTPS|

## 実行スクリプト

### 共通

```sh
cd Path/to/podman-container-nginx
sudo firewall-cmd --permanent --new-service=user-nginx
sudo firewall-cmd --permanent --service=user-nginx --add-port=8080/tcp
sudo firewall-cmd --permanent --service=user-nginx --add-port=8443/tcp
sudo firewall-cmd --permanent --add-service=user-nginx

sudo firewall-cmd --reload
```

### Quadlet使用時

```sh
mkdir -p $HOME/.config/containers/systemd/
cp Quadlet/* $HOME/.config/containers/systemd/
systemctl --user daemon-reload

systemctl --user start podman_build_nginx
systemctl --user start podman_container_nginx
```

### Quadlet非使用時

```bash
podman build --tag nginx --file nginx/Dockerfile .
podman run --name nginx --publish 8080:8080/tcp --publish 8443:8443/tcp --mount type=volume,source=nginx,destination=/V --detach --replace nginx
```

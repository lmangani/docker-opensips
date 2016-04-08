# Dockerizing OpenSIPS Service
本專案將 OpenSIPS 進行封裝成 Docker 映像檔，來提供快速的部署 VoIP 應用程式，免除過往指令與腳本式安裝的諸多不便。

### 建置 OpenSIPS 映像檔
首先 Clone 該專案，然後進入到專案目錄底下，透過 Docker 指令來建置映像檔：
```sh
$ docker build -t imac-cloud/opensips:1.0.0 .
```

### 快速開始
透過以下指令執行一個簡單的 OpenSIPS 服務：
```sh
$ docker run --name opensips -d -p 5060:5060/udp \
-e ADVERTISED_IP="<ADVERTISED_IP>" \
imac-cloud/opensips:1.0.0
```

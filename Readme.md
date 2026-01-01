# Docker deployment of SOCKS5 proxy over SSH

To deploy server run:

```sh
# Prepare authorized_keys file for ssh, e.g.:
echo <MY_PUBLIC_SSH_KEY> >>authorized_keys

# And deploy via docker-compose
docker compose up -d --build
```

To setup local proxy on client, use following command:

```sh
ssh -D <LOCAL_PROXY_PORT> proxyuser@<SERVER_ADDRESS> -p 2222 -i ~/.ssh/<MY_PRIVATE_SSH_KEY>
```

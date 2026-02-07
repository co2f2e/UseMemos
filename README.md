# memos

<hr>

## Installation
```bash
bash <(curl -Ls https://raw.githubusercontent.com/Meokj/memos/main/install.sh) 7000
```

## Uninstallation
```bash
bash <(curl -Ls https://raw.githubusercontent.com/Meokj/memos/main/uninstall.sh) 
```

## NGINX Configuration
```nginx
    location / {
        proxy_pass http://127.0.0.1:7000/;
        proxy_http_version 1.1;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_buffering off;
    }
```

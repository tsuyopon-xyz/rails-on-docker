# 概要

Docker を使ったローカル開発環境

## rails new 実行時のコマンド

```sh
docker compose run --rm web rails new . --api --force --database=mysql --skip-turbolinks --skip-test
```

## 起動, 停止など

- Makefile にまとめているのでそれを参照すること

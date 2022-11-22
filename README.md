# 概要

Docker を使ったローカル開発環境

## rails new 実行時のコマンド

### API モード

```sh
docker compose run --rm web rails new . --api --force --database=mysql --skip-turbolinks --skip-test
```

### 通常モード（MySQL を指定）

```sh
docker compose run --rm web rails new . --force --database=mysql
```

## 起動, 停止など

- Makefile にまとめているのでそれを参照すること

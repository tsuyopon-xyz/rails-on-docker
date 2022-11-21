# 参考
# - https://qiita.com/Yusuke_Hoirta/items/3a50d066af3bafbb8641
# - https://docs.docker.jp/compose/rails.html
# - https://zenn.dev/mochiblock/articles/aaa4724c6267e6

FROM ruby:2.7.6

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-mysql-client vim
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

ENV APP /app
RUN mkdir ${APP}
WORKDIR ${APP}

COPY Gemfile Gemfile.lock ${APP}/
RUN bundle install

COPY . ${APP}

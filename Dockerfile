# 参考
# - https://qiita.com/Yusuke_Hoirta/items/3a50d066af3bafbb8641
# - https://docs.docker.jp/compose/rails.html
# - https://zenn.dev/mochiblock/articles/aaa4724c6267e6
# - https://zenn.dev/yuma_ito_bd/scraps/1adb89dfe0661c

FROM ruby:2.7.6

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-mysql-client vim
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev default-mysql-client vim
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs

# For webpacker
# Yarn not installed. Please download and install Yarn from https://yarnpkg.com/lang/en/docs/install/
RUN npm install --global yarn

ENV TZ Asia/Tokyo
ENV APP /app

RUN mkdir ${APP}
WORKDIR ${APP}

COPY Gemfile Gemfile.lock ${APP}/
RUN bundle install

COPY . ${APP}

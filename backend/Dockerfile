# FROM：使用するイメージ、バージョン
FROM ruby:3.1.4
# 公式→https://hub.docker.com/_/ruby

RUN apt-get update && \
    apt-get install -y vim

# Rails 7ではWebpackerが標準では組み込まれなくなったので、yarnやnodejsのインストールが不要

# ruby3.1のイメージがBundler version 2.3.7で失敗するので、gemのバージョンを追記
ARG RUBYGEMS_VERSION=3.3.20

# RUN：任意のコマンド実行
RUN mkdir /backend

# WORKDIR：作業ディレクトリを指定
WORKDIR /backend

# COPY：コピー元とコピー先を指定
# ローカルのGemfileをコンテナ内の/app/Gemfileに
COPY rails_project/Gemfile /backend/Gemfile

COPY rails_project/Gemfile.lock /backend/Gemfile.lock

# RubyGemsをアップデート
RUN gem update --system ${RUBYGEMS_VERSION} && \
    bundle install

# COPY . /atcoder_app

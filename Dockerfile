FROM ruby:latest

RUN apt-get update -qq && apt-get install -y apt-utils build-essential libpq-dev nodejs

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install uglifier
RUN gem install tzinfo-data
RUN bundle install

COPY . .

LABEL maintainer="Nick Janetakis <nick.janetakis@gmail.com>"
RUN useradd -m -s /bin/bash -u 1000 postgres
RUN chown -R postgres:postgres .
USER postgres

FROM ruby:3.0.0


ENV APP_ROOT /app
ENV TZ Asia/Tokyo

RUN rails new .

RUN apt-get update -qq

RUN apt-get install -y build-essential libpq-dev nodejs mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

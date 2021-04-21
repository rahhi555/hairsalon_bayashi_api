FROM ruby:3.0.0


ENV APP_ROOT /app
ENV TZ Asia/Tokyo

RUN apt-get update -qq

RUN apt-get install -y build-essential libpq-dev nodejs mariadb-client vim \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR $APP_ROOT

COPY . $APP_ROOT
RUN chmod +x $APP_ROOT/entrypoint.sh

RUN bundle install

RUN rm ./config/credentials.yml.enc
RUN EDITOR=vim rails credentials:edit

ENTRYPOINT ["/app/entrypoint.sh"]
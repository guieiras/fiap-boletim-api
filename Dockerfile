FROM ruby:2.5.1-slim
ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y libpq-dev build-essential && \
    rm -rf /var/lib/apt/lists/*

# Cache bundle install
WORKDIR /tmp

COPY ./Gemfile Gemfile
COPY ./Gemfile.lock Gemfile.lock
RUN bundle install

ENV APP_ROOT /workspace
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY . $APP_ROOT

EXPOSE 4567
CMD ["ruby", "server.rb", "-o", "0.0.0.0"]

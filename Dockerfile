FROM ruby:2.7.5

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
  apt-get update && apt-get install -y nodejs nginx supervisor neovim python2 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY . /app
WORKDIR /app
COPY config/master.key /app/config/

ENV RAILS_ENV=production
ENV NODE_OPTIONS=--openssl-legacy-provider

RUN gem install bundler -v 2.4.22
RUN bundle config set without 'development test' && bundle install

RUN corepack enable && yarn

RUN bundle exec rake assets:precompile --trace

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]

FROM ruby:2.7.5

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
  apt-get update && apt-get install -y nodejs nginx supervisor nano && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

ENV RAILS_ENV=production
#ENV RAILS_MASTER_KEY=

RUN bundle config set without 'development test'
RUN bundle install
RUN corepack enable
RUN yarn install
RUN yarn compile
RUN yarn build-packages
#RUN yarn install --check-files

RUN RAILS_ENV=production bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]



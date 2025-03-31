FROM ruby:2.7.5

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
  apt-get update && apt-get install -y nodejs nginx supervisor nano && \
  npm install -g yarn && \
  apt-get install python2.7 -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

#RUN npm config set python /usr/bin/python2.7
ENV npm_config_python=/usr/bin/python3

#RUN ln -s /usr/bin/python2.7 python
#RUN ln -s /usr/bin/python2.7 python2

WORKDIR /app
COPY . /app
COPY config/master.key /app/config/

ENV RAILS_ENV=production
#ENV RAILS_MASTER_KEY=

RUN gem install bundler -v 2.4.22
RUN bundle config set without 'development test'
RUN bundle install
RUN yarn install

RUN RAILS_ENV=production bundle exec rake assets:precompile --trace

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]



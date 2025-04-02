FROM ruby:2.7.5

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get update && apt-get install -y nodejs nginx supervisor neovim python2
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN npm install -g corepack@latest
RUN corepack enable && yarn

COPY . /app
WORKDIR /app

ENV RAILS_ENV=production
ENV NODE_OPTIONS=--openssl-legacy-provider
#ENV RAILS_SERVE_STATIC_FILES=true
ENV TZ="Europe/Moscow"
ENV RAILS_LOG_TO_STDOUT=1

RUN gem install bundler -v 2.4.22
RUN bundle config set without 'development test'
RUN bundle config set build.sassc --disable-march-tune-native
RUN bundle config set build.bootsnap --disable-march-tune-native
RUN bundle install

RUN bundle exec rake assets:precompile --trace

RUN rm /app/config/master.key

RUN rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
RUN ln -s /app/config/nginx/default.conf /etc/nginx/conf.d/default.conf
RUN cp ./config/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
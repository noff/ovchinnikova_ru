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
#ENV RAILS_SERVE_STATIC_FILES=true
ENV TZ="Europe/Moscow"

RUN gem install bundler -v 2.4.22
RUN bundle config set without 'development test' && bundle install

RUN corepack enable && yarn

RUN bundle exec rake assets:precompile --trace

RUN rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default &&\
    ln -s /app/config/nginx/default.conf /etc/nginx/conf.d/default.conf &&\
    cp ./config/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080

#CMD ["bin/rails", "server", "-b", "0.0.0.0"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
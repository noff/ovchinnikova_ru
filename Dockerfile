FROM ruby:2.7.5

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
  apt-get update && apt-get install -y nodejs nginx supervisor nano && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY . /app
WORKDIR /app

ENV RAILS_ENV=production
ENV RAILS_MASTER_KEY=54ba023fc6ab4295dba948019159a685

RUN bundle config set without 'development test'
RUN bundle install
RUN npm install

RUN bin/rake assets:precompile

#WORKDIR /usr/src/app
#
#ENV GEM_HOME="/usr/local/bundle"
#ENV PATH=$GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH
#ENV RAILS_LOG_TO_STDOUT=true

#ENV BUNDLE_PATH=/bundle
#ENV RAILS_ENV=production
#ENV BUNDLE_PATH=/usr/local/bundle
#ENV BUNDLE_APP_CONFIG=/usr/local/bundle

#COPY Gemfile Gemfile.lock ./
#RUN gem install bundler
#RUN gem install bundler -v 2.1.4
#RUN gem install bundler -v 2.3.27 --no-document
#RUN bundle install --without development test
#RUN bundle update
#RUN bundle config set without 'development test'
#RUN bundle config --global frozen 1
#RUN bundle install
#RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]



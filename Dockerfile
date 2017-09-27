FROM ruby:2.4
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN apt-get install -y nodejs npm

# upgrade node
RUN npm cache clean && npm install n -g
RUN n stable && ln -sf /usr/local/bin/node /usr/bin/node
RUN apt-get purge -y nodejs npm

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME

RUN mkdir /bundle && chmod go+wx /bundle
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile BUNDLE_PATH=/bundle GEM_HOME=/bundle
ENV PATH=$PATH:/bundle/bin

Run gem install foreman

RUN apt-get install -y imagemagick

# workarround for git-clone fails when current user is not in /etc/passwd
RUN git config --system user.name Docker && git config --system user.email docker@localhost
EXPOSE 3000


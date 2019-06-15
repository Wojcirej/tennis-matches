FROM ruby:2.6.3

RUN mkdir /application

WORKDIR /application

COPY . .

ENV RAILS_ENV production

RUN bundler install --without development test \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt install -y nodejs

RUN rails assets:precompile

CMD ["rails", "server"]

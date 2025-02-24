# from ruby
FROM ruby:3.4.2-slim-bookworm

# install gem code2pdf
RUN gem install code2pdf

# set workdir
WORKDIR /code

# set entrypoint
CMD ["code2pdf"]
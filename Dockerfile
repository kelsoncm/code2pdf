# from ruby
FROM ruby:2.7.7

# install gem code2pdf
RUN gem install code2pdf

# set workdir
WORKDIR /code

# set entrypoint
CMD ["code2pdf"]
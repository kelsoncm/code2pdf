# from ruby
FROM ruby:2

# install gem code2pdf
RUN gem install code2pdf

# set workdir
WORKDIR /code

# set entrypoint
ENTRYPOINT ["code2pdf"]
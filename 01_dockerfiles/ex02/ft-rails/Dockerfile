# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gfielder <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/05/08 12:29:18 by gfielder          #+#    #+#              #
#    Updated: 2019/05/08 17:40:39 by gfielder         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ----- Prompt ----------------------------------------------------------------
# You are going to create your first Dockerfile to containerize Rails applications
# That’s a special configuration: this particular Dockerfile will be generic,
# and called in another Dockerfile, that will look something like this:
# 
#   FROM ft-rails:on-build
#   EXPOSE 3000
#   CMD ["rails", "s", "-b", "0.0.0.0", "-p", "3000"]
# 
# Your generic container should install, via a ruby container, all the
# necessary dependencies and gems, then copy your rails application in the
# /opt/app folder of your container. Docker has to install the approtiate gems
# when it builds, but also launch the migrations and the db population for your
# application. The child Dockerfile should launch the rails server (see example
# below). If you don’t know what commands to use, it’s high time to look at the
# Ruby on Rails documentation.
# -----------------------------------------------------------------------------

# ----- Notes -----------------------------------------------------------------
# https://hub.docker.com/_/ruby
# https://guides.rubyonrails.org/getting_started.html
#
# db:migrate and db:seed are special rake commands; see
#  https://dev.to/neshaz/how-to-use-rake-db-commands-in-the-correct-way--50o2
# I assume rake has to run a general 'rake' just like make to build anything
# else the application needs to run.
# I use rake 12.3.1 because the app I'm packaging with submission to test
# this requires it.
# -----------------------------------------------------------------------------

# Basic ruby image setup
FROM ruby:latest
RUN apt-get update -y && apt-get install -y \
	build-essential \
	libpq-dev \
	nodejs \
	sqlite3 \
	gem
RUN gem install bundler --no-document
RUN gem install rails --no-document
RUN gem install rake -v 12.3.1 --no-document

# Run on ft-rails:on-build
ONBUILD COPY app /opt/app
ONBUILD WORKDIR /opt/app
ONBUILD EXPOSE 3000
ONBUILD RUN bundle install
ONBUILD RUN rake _12.3.1_ db:migrate
ONBUILD RUN rake _12.3.1_ db:seed
ONBUILD RUN rake _12.3.1_

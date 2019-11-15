# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gfielder <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/05/08 12:29:18 by gfielder          #+#    #+#              #
#    Updated: 2019/05/09 16:03:56 by gfielder         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ----- Prompt ----------------------------------------------------------------
# Docker can be useful to test an application that’s still being developed
# without polluting your libraries. You will have to design a Dockerfile that
# gets the development version of Gitlab - Community Edition installs it with
# all the dependencies and the necessary configurations, and launches the
# application, all as it builds. The container will be deemed valid if you can
# access the web client, create users and interact via GIT with this container
# (HTTPS and SSH). Obviously, you are not allowed to use the official container
# from Gitlab, it would be a shame...
# -----------------------------------------------------------------------------

# ----- Notes -----------------------------------------------------------------
# Installing and Configuring Gitlab
# https://docs.gitlab.com/omnibus/README.html#installation-and-configuration-using-omnibus-package
#
# Some people choose to run `gitlab-ctl reconfigure` inside the image
# generation process, but when I tried this, it hangs on
#    ruby_block[wait for redis service socket] action run
# which is apparently a bug in gitlab in some environments including docker,
# So we have to configure gitlab only after starting up ubuntu.
#
# tzdata is a time zone data package. It's not listed in the gitlab
# dependencies, nor do I know why some people included it. The build and
# configure commands take far too long to bother testing without it, though.
#
# runsvdir-start starts up runsvdir, which needs to run in the background.
# As this is a process dependency for gitlab, I `sleep 2` just to give
# it time to stabilize.
#
# Usually I run docker containers as daemon processes (-d), but that hides the
# output, in which case you'd never know when (if ever) gitlab-ctl reconfigure
# completes and we can use gitlab. Without using -d, we need an alternate way
# to keep the container running while we use its services. That is the point
# of using `tail -f /dev/null`, as this is meant to be an infinite loop
# command, which is a hacky way of keeping the container running.
#
# The instructions to enable SSH are misleading and unnecessary. I think it
# likely to be a case of the subject pdf being outdated.
# https://blog.docker.com/2014/06/why-you-dont-need-to-run-sshd-in-docker/
#
# I tried anyway, but docker isn't set up to work this way as far as I can
# tell, and trying to run a separate SSHD is more difficult than this exercise
# seems to intend.
# In any case, `docker-exec -it [container] sh` is an equivalent to SSH into
# the container. Docker also has another alternative here:
# https://docs.docker.com/engine/reference/commandline/attach/
# -----------------------------------------------------------------------------

FROM ubuntu

RUN apt-get update -y && apt-get -y upgrade \
	&& apt-get -y install \
	wget \
	openssh-server \
	ca-certificates \
	postfix

# Setting up SSHD
# adapted from https://docs.docker.com/engine/examples/running_ssh_service/#run-a-test_sshd-container
# RUN mkdir /var/run/sshd
# RUN echo 'root:root' | chpasswd
# RUN sed -i 's/^.*?PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
# ENV NOTVISIBLE "in users profile"
# RUN echo "export VISIBLE=now" >> /etc/profile

# Install Gitlab
RUN wget \
	https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh \
	&& chmod 777 ./script.deb.sh && ./script.deb.sh
RUN apt-get install -y tzdata gitlab-ce

EXPOSE 443 80 22

ENTRYPOINT (/opt/gitlab/embedded/bin/runsvdir-start &) && sleep 2 && gitlab-ctl reconfigure && tail -f /dev/null


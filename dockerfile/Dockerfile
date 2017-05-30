#
# yocto Dockerfile
#
# https://github.com/RobertBerger/yocto-autobuilder
#

# Pull base image.
FROM reliableembeddedsystems/yocto:pyro-2017-05-29
#FROM reslocal/yocto

# Ubuntu and Debian Yocto dependencies:
# The essential and graphical support packages you need for a supported Ubuntu or Debian distribution are shown in the following command: 
#RUN sudo apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath libsdl1.2-dev xterm
# additional (old?) Yocto dependencies:
#RUN sudo apt-get install -y make xsltproc docbook-utils fop autoconf automake libtool libglib2.0-dev

# update
RUN sudo apt-get update

# buildbot dependencies
RUN sudo apt-get install -y libjs-sphinxdoc libjs-underscore python-decorator python-jinja2 python-markupsafe python-migrate
RUN sudo apt-get install -y python-sqlalchemy python-sqlalchemy-ext python-sqlparse python-tempita python-twisted-mail
RUN sudo apt-get install -y python-twisted-names python-twisted-web python-twisted-words
RUN sudo apt-get install -y javascript-common python-jinja2-doc python-sqlalchemy-doc python-psycopg2 python-mysqldb
RUN sudo apt-get install -y python-kinterbasdb python-pymssql

# autobuilder dependencies
RUN sudo apt-get install -y tightvncserver xtightvncviewer sqlite

# for bitbake core-image-minimal -g -u depexp
RUN sudo apt-get install -y python-gobject-2 python-gtk2

# for bitbake core-image-minimal -g -u depexp - Morty
RUN sudo apt-get install -y libgtk-3-0 libgtk-3-bin libgtk-3-common libgtk-3-dev python3-gi

# tools I use
RUN sudo apt-get install -y pv

# for hob
RUN sudo apt-get install -y python-gtk2

# for toaster
RUN sudo apt-get install -y python-pip xdg-utils

# autobuilder patching
RUN puppet apply --modulepath=/modules -e "class { 'autobuilder_before_install': }"

# here we actually install the yocto-autobuilder
RUN (su genius -c "cd /home/genius/test/yocto-autobuilder ; ./yocto-stop-autobuilder both; . ./yocto-autobuilder-setup; ./yocto-start-autobuilder both")

# default yoctoAB stuff
#RUN (su genius -c "cd /home/genius/test/meta-mainline/multi-v7-ml/yocto-autobuilder ; git pull; cp res-custom-pyro-multi-v7-core-image-minimal /tmp/yocto-autobuilder/yocto-autobuilder/buildset-config; cp yoctoAB.conf /tmp/yocto-autobuilder/yocto-autobuilder/buildset-config")

# Add one time startup script to start yocto-autobuilder
ADD etc_my_init.d/02_start_autobuilder.sh /etc/my_init.d/02_start_autobuilder.sh

# make byobu backend screen
RUN find /etc/byobu/backend -exec sed -i 's/tmux/screen/g' {} \;

# in case the sanity tests failed
#RUN sudo apt-get install -y tightvncserver xtightvncviewer

# some permissions got screwed up (puppet?) - fix:
RUN chown genius:genius /home/genius
RUN chown genius:genius /home/genius/test

# what works on non-docker Ubuntu 16 for toaster
RUN sudo apt-get install -y python-pip
#RUN (su genius -c "sudo -H pip install --upgrade pip")
#RUN (su genius -c "sudo -H pip install django==1.6")
#RUN (su genius -c "sudo -H pip install south==0.8.4")
RUN sudo apt-get install -y daemon

# more for toaster
#ADD bitbake/toaster-requirements.txt /home/genius/bitbake/toaster-requirements.txt
#RUN sudo pip install -r /home/genius/bitbake/toaster-requirements.txt

# what works on non-docker Ubuntu 16 for toaster
RUN sudo apt-get install -y python-pip
#RUN (su genius -c "sudo -H pip install --upgrade pip")
#RUN (su genius -c "sudo -H pip install django==1.6")
#RUN (su genius -c "sudo -H pip install south==0.8.4")
RUN sudo apt-get install -y daemon

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

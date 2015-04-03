#
# yocto Dockerfile
#
# https://github.com/RobertBerger/yocto-autobuilder
#

# Pull base image.
FROM reliableembeddedsystems/yocto

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

# tools I use
RUN sudo apt-get install -y pv

# for hob
RUN sudo apt-get install python-gtk2

# for toaster
RUN sudo apt-get install -y python-pip xdg-utils

# autobuilder patching
RUN puppet apply --modulepath=/modules -e "class { 'autobuilder_before_install': }"

# here we actually install the yocto-autobuilder
RUN (su genius -c "cd /home/genius/test/yocto-autobuilder ; ./yocto-stop-autobuilder both; . ./yocto-autobuilder-setup; ./yocto-start-autobuilder both")

# Add one time startup script to start yocto-autobuilder
ADD etc_my_init.d/02_start_autobuilder.sh /etc/my_init.d/02_start_autobuilder.sh

# in case the sanity tests failed
#RUN sudo apt-get install -y tightvncserver xtightvncviewer

# some permissions got screwed up (puppet?) - fix:
RUN chown genius:genius /home/genius
RUN chown genius:genius /home/genius/test

# more for toaster
ADD bitbake/toaster-requirements.txt /home/genius/bitbake/toaster-requirements.txt
RUN sudo pip install -r /home/genius/bitbake/toaster-requirements.txt

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

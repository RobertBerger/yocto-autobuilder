#
# yocto Dockerfile
#
# https://github.com/RobertBerger/yocto-autobuilder
#

# Pull base image.
FROM reliableembeddedsystems/ubuntu-base

# Ubuntu and Debian Yocto dependencies:
# The essential and graphical support packages you need for a supported Ubuntu or Debian distribution are shown in the following command: 
RUN sudo apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath libsdl1.2-dev xterm
# additional (old?) Yocto dependencies:
RUN sudo apt-get install -y make xsltproc docbook-utils fop autoconf automake libtool libglib2.0-dev

# buildbot dependencies
RUN sudo apt-get install -y libjs-sphinxdoc libjs-underscore python-decorator python-jinja2 python-markupsafe python-migrate
RUN sudo apt-get install -y python-sqlalchemy python-sqlalchemy-ext python-sqlparse python-tempita python-twisted-mail 
RUN sudo apt-get install -y python-twisted-names python-twisted-web python-twisted-words
RUN sudo apt-get install -y javascript-common python-jinja2-doc python-sqlalchemy-doc python-psycopg2 python-mysqldb 
RUN sudo apt-get install -y python-kinterbasdb python-pymssql

# autobuilder dependencies
RUN sudo apt-get install -y tightvncserver xtightvncviewer sqlite

# in case the sanity tests failed
RUN sudo apt-get install -y tightvncserver xtightvncviewer

# somehow permissions got screwed up
RUN chown -R genius:genius /home/genius

# Set environment variables.
ENV HOME /home/genius

# Define working directory.
WORKDIR /home/genius

# Default User
USER genius

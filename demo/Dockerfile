FROM docker.io/berkeleydsep/singleuser-data8:v0.1

MAINTAINER Ryan Lovett <rylo@berkeley.edu>

ADD README.ipynb /home/jovyan
ADD install-demo.bash /usr/local/sbin/install-demo.bash
RUN /usr/local/sbin/install-demo.bash

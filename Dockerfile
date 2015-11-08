FROM centos:6

# Install packages
RUN yum -y groupinstall "Development tools"
RUN yum -y install zlib-devel
RUN yum -y install bzip2-devel
RUN yum -y install openssl-devel
RUN yum -y install ncurses-devel
RUN yum -y install sqlite-devel
RUN yum -y install tar

# Install python 2.7
WORKDIR /tmp/install
RUN curl -O https://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz 
RUN tar xvzf Python-2.7.6.tgz
WORKDIR Python-2.7.6
RUN ./configure --prefix=/usr/local
RUN make 
RUN make altinstall

# Symlink
RUN ln -s /usr/local/bin/python2.7 /usr/local/bin/python

# Install pip
WORKDIR /tmp/install
RUN curl -O https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
RUN /usr/local/bin/python2.7 ez_setup.py
RUN /usr/local/bin/easy_install-2.7 pip

# Install Ansible
RUN pip install ansible

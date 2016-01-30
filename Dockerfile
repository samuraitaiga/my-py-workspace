FROM centos:6
MAINTAINER samuraitaiga

WORKDIR /root

# install and setting ssh
RUN yum install -y passwd openssh openssh-server openssh-clients sudo
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN echo 'root:docker' |chpasswd
RUN useradd docker
RUN echo 'docker:docker' |chpasswd
RUN echo "docker    ALL=(ALL)       ALL" >> /etc/sudoers.d/docker

# setup workspace
RUN yum install -y vim-enhanced git python-setuptools
RUN easy_install pip
RUN curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
RUN sh ./install.sh
RUN curl https://raw.githubusercontent.com/samuraitaiga/my-py-workspace/master/.vimrc > ~/.vimrc
RUN curl https://raw.githubusercontent.com/samuraitaiga/my-py-workspace/master/.bashrc > ~/.bashrc
RUN curl https://raw.githubusercontent.com/samuraitaiga/my-py-workspace/master/run.sh > ~/run.sh
RUN chmod +x ~/run.sh
RUN vim +NeoBundleInstall +qall

EXPOSE 22
ENTRYPOINT ["/root/run.sh"]

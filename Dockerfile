FROM ubuntu:latest
MAINTAINER Can MOGOL (canmogol@gmail.com)
USER root
RUN apt-get update
RUN apt-get install exuberant-ctags maven nodejs npm openjdk-8-jdk python python-dev build-essential cmake sudo vim curl git bash-completion htop openssh-server byobu ruby -y
RUN update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true" >> /etc/profile
RUN echo "findmega(){du -h --max-depth=1 $1 | grep '[0-9]M\>'}" >> /etc/profile
RUN echo "findgiga(){du -h --max-depth=1 $1 | grep '[0-9]G\>'}" >> /etc/profile
RUN echo "alias vi=vim" >> /etc/profile
RUN echo "export MAVEN_OPTS=\"-Xmx768m -XX:MaxPermSize=196m\"" >> /etc/profile
RUN echo "export HISTFILESIZE=10000" >> /etc/profile
RUN echo "export HISTSIZE=10000" >> /etc/profile
RUN echo "export VISUAL=vim" >> /etc/profile
RUN echo "export EDITOR=\"$VISUAL\"" >> /etc/profile
RUN echo "source /etc/bash_completion" >> /etc/profile
RUN echo "byobu new-session" >> /etc/profile
RUN useradd -ms /bin/bash can
RUN echo 'can:can' | chpasswd
RUN mkdir -p /home/can && \
	echo "can ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/can && \
	chmod 0440 /etc/sudoers.d/can
RUN echo "devenv" > /etc/hostname

RUN mkdir -p /home/can/.vim/autoload /home/can/.vim/bundle && curl -LSso /home/can/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
COPY bundle.rb /home/can/.vim/
COPY .vimrc /home/can/
COPY .bash_ps1 /home/can/
RUN echo "source /home/can/.bash_ps1" >> /home/can/.bashrc
RUN chmod 755 /home/can/.vim/bundle.rb
RUN chown can:can -R /home/can
RUN cd /home/can/.vim; ./bundle.rb
RUN chown can:can -R /home/can

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

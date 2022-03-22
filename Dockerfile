FROM ubuntu:14.04

EXPOSE 22

RUN sed -i 's/archive.ubuntu/mirrors.aliyun/g' /etc/apt/sources.list

# it seems ubuntu14.04 contains openjdk7
RUN apt-get update && \
    apt-get install flex bison build-essential csh openjdk-6-jdk libxaw7-dev wget openssh-server -y && \
    mkdir /usr/cs143 ~/code && \
    wget https://courses.edx.org/asset-v1:StanfordOnline+SOE.YCSCS1+1T2020+type@asset+block@student-dist.tar.gz -O student-dist.tar.gz && \
    tar -xf student-dist.tar.gz
RUN echo "service ssh start\nexport PATH=/usr/cs143/bin:$PATH" >> ~/.bashrc

# change password and allow login
RUN echo "root\nroot" | passwd && \
    sed -i "s/without-password/yes/" /etc/ssh/sshd_config

WORKDIR /root/code

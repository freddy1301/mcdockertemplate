FROM docker.io/ubuntu

RUN apt update && apt upgrade -y && apt autopurge -y
RUN apt install apt-transport-https ca-certificates wget dirmngr gnupg software-properties-common -y && wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && apt update && apt install adoptopenjdk-8-hotspot -y && java -version
RUN apt install openjdk-17-jdk-headless -y
RUN apt install screen htop nano net-tools zip unzip cron openssh-server git -y
RUN apt update && apt upgrade -y && apt autoremove -y
RUN apt clean

RUN mkdir /home/mcserver
RUN chmod 777 /home/mcserver

EXPOSE 25565
EXPOSE 22/tcp

RUN wget https://papermc.io/api/v2/projects/paper/versions/1.18.1/builds/150/downloads/paper-1.18.1-150.jar
RUN cp paper-1.18.1-150.jar /home/mcserver/paper.jar
RUN rm paper-1.18.1-150.jar
RUN ln -s /home/mcserver/paper.jar start.jar

RUN echo eula=true > eula.txt
RUN cp eula.txt /home/mcserver
RUN rm eula.txt

RUN mkdir /home/git_download
RUN git clone https://github.com/freddy1301/mcdockertemplate.git /home/git_download
RUN cp -r /home/git_download/ressources/* /home/mcserver

CMD cd /home/mcserver && java -jar /home/mcserver/paper.jar
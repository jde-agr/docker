# FROM debian

# # Set the Teamspeak version to download
# ENV TSV=3.0.13.8

# # Download and install everything from the repos.
# RUN DEBIAN_FRONTEND=noninteractive \
#   apt-get -y update && \
#   apt-get -y install bzip2 && \
#   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
#   apt-get autoremove -y && \
#   apt-get clean

# # Download and install TeamSpeak 3
# ADD http://dl.4players.de/ts/releases/${TSV}/teamspeak3-server_linux_amd64-${TSV}.tar.bz2 ./

# RUN tar jxf teamspeak3-server_linux_amd64-$TSV.tar.bz2 && \
#        mv teamspeak3-server_linux_amd64 /opt/teamspeak && \
#        rm teamspeak3-server_linux_amd64-$TSV.tar.bz2

# # Load in all of our config files.
# ADD entrypoint.sh /entrypoint.sh

# #  9987 default voice
# # 10011 server query
# # 30033 file transport
# EXPOSE 9987/udp 10011 30033 

# ENTRYPOINT [ "/entrypoint.sh" ]

# #docker build -t jde-agr/ex01-teamspeak
# #docker run -it --rm -p=9987:9987/udp  -p=10011:10011 -p=30033:30033 jde-agr/ex01-teamspeak

FROM debian
ENV TS3SERVER_LICENSE=accept
WORKDIR /home/teamspeak
EXPOSE 9987/udp 10011 30033
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget bzip2
RUN wget http://dl.4players.de/ts/releases/3.7.1/teamspeak3-server_linux_amd64-3.7.1.tar.bz2
RUN tar -xvf teamspeak3-server_linux_amd64-3.7.1.tar.bz2

WORKDIR teamspeak3-server_linux_amd64
ENTRYPOINT sh ts3server_minimal_runscript.sh
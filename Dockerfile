FROM brsynth/galaxy:py3

# Install Docker
RUN apt-get update \
 && apt-get -y install apt-transport-https \
                       ca-certificates \
                       curl \
                       gnupg2 \
                       software-properties-common \
 && curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey \
 && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" \
 && apt-get update \
 && apt-get -y install docker-ce

VOLUME /var/lib/docker

COPY entrypoint.sh /

RUN chmod u+x /entrypoint.sh && gpasswd -a galaxy docker

ENTRYPOINT ["/entrypoint.sh"]

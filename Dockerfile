FROM brsynth/galaxy:py27

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
 && apt-get -y install docker-ce docker-ce-cli containerd.io \
 && apt-get autoremove -y && apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
 && chmod +x /usr/local/bin/docker-compose

VOLUME /var/lib/docker

COPY entrypoint.sh /

COPY resolv.conf /

RUN chmod u+x /entrypoint.sh \
 && gpasswd -a galaxy docker

ENTRYPOINT ["/entrypoint.sh"]

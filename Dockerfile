FROM zencash/botio-base:https

MAINTAINER cronicc@protonmail.com

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y install build-essential ruby-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN gem install jekyll bundler -N

RUN npm install -g bower gulp

RUN mkdir -p /home/temp

RUN git clone -b master --single-branch https://github.com/ZencashOfficial/botio-files-zensystem.io.git /home/temp/botio-files \
    && cd /home/temp/botio-files \
    && npm install

EXPOSE 8000

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["botio start -u $GITHUB_USER -p $GITHUB_PASS"]

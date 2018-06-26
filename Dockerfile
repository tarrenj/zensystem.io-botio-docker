FROM smrtz/botio-good

MAINTAINER cronicc@protonmail.com

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y install build-essential ruby-dev locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8

RUN gem install jekyll bundler -N

RUN npm install -g bower gulp

RUN mkdir -p /home/temp

RUN git clone -b master --single-branch https://github.com/tarrenj/botio-files-zensystem.io.git /home/temp/botio-files \
    && cd /home/temp/botio-files \
    && npm install

EXPOSE 8000

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["botio start -u $GITHUB_USER -p $GITHUB_PASS"]

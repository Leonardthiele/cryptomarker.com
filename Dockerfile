FROM elixir:1.5-slim as dependency-cache

ENV HOME=/opt/app

RUN apt-get update && apt-get -y install git && rm -rf /var/lib/apt/lists/*
RUN mix do local.hex --force, local.rebar --force

# Cache elixir deps

WORKDIR /opt/app
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

###############################################################
FROM elixir:1.5-slim

RUN apt-get update && apt-get -y install \
        git make g++ wget curl build-essential locales python \
        mysql-client \
        imagemagick \
        # for wkhtmltopdf
        xvfb libxrender1 xfonts-utils xfonts-base xfonts-75dpi \
        libfontenc1 x11-common xfonts-encodings libxfont1 \
        ttf-freefont fontconfig dbus && \
        curl -sL https://deb.nodesource.com/setup_8.x | bash && \
        apt-get -y install nodejs && \
        rm -rf /var/lib/apt/lists/*

# Set the locale
RUN locale-gen en_US.UTF-8 && \
    localedef -i en_US -f UTF-8 en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN \
    mkdir -p /opt/app && \
    chmod -R 777 /opt/app && \
    update-ca-certificates --fresh

# Add local node module binaries to PATH
ENV PATH=./node_modules/.bin:$PATH \
    HOME=/opt/app

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /opt/app

# Set exposed ports
EXPOSE 4000
ENV PORT=4000 MIX_ENV=prod

# Cache elixir deps
COPY --from=dependency-cache $HOME/deps $HOME/deps
COPY --from=dependency-cache $HOME/_build $HOME/_build

# Same with npm deps
ADD ./assets/package.json ./assets/package.json
RUN cd assets && npm install

ADD . .

# Run frontend build, compile, and digest assets
RUN cd assets && brunch build --production && cd .. && \
    mix do compile, phx.digest

# USER default

CMD ["mix", "phx.server"]

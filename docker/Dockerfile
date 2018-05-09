FROM elixir:1.6

RUN mkdir /appdev

WORKDIR /appdev

COPY ./mix.exs .

ENV MIX_ENV=dev

RUN mix local.hex --force
RUN mix deps.get --force
RUN mix local.rebar --force
RUN mix compile --force

ENV ERLANG_COOKIE=ABEC8B24-F955-4732-BE74-BA5E40433266

RUN apt-get update
RUN apt-get --yes install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
    && apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable"
RUN apt-get update && apt-get --yes install docker-ce

EXPOSE 8000

CMD ./docker/start.sh

FROM gliderlabs/alpine:latest
MAINTAINER info@garycrawford.co.uk

# Install Java
RUN \
  apk update && \
  apk add openjdk7-jre-base

# Install Clojure
RUN \
  apk add ca-certificates && \
  apk add curl && \
  apk add bash && \
  curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /bin/lein && \
  chmod u+x /bin/lein && \
  lein

ENV LEIN_ROOT 1

FROM gliderlabs/alpine:latest
MAINTAINER <info@garycrawford.co.uk>

# Install dependencies
RUN apk update && \
    apk add ca-certificates && \
    apk add curl && \
    apk add bash && \
    apk add openjdk7-jre-base

# Add required certs
COPY cacerts /usr/lib/jvm/java-1.7-openjdk/jre/lib/security/

# Ensure lein can run as root
ENV LEIN_ROOT 1

# Install Clojure
RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /bin/lein && \
    chmod u+x /bin/lein && \
    lein

FROM progrium/busybox
MAINTAINER Gary Crawford <info@garycrawford.co.uk>

RUN opkg-install ca-certificates curl bash

RUN for cert in `ls -1 /etc/ssl/certs/*.crt | grep -v /etc/ssl/certs/ca-certificates.crt`; \
      do cat "$cert" >> /etc/ssl/certs/ca-certificates.crt; \
    done

# Install Java
RUN curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jre-8u25-linux-x64.tar.gz > /tmp/jre.tar.gz && \
     gunzip /tmp/jre.tar.gz && \
     tar xf /tmp/jre.tar -C /opt && \
     rm /tmp/jre.tar && \
     ln -s /opt/jre1.8.0_25/bin/java /usr/bin/java && \
     cd /opt/jre1.8.0_25 && \
     rm -rf lib/*javafx* \
            lib/plugin.jar \
            lib/ext/jfxrt.jar \
            bin/javaws \
            lib/javaws.jar \
            lib/desktop \
            plugin \
            lib/deploy* \
            lib/*javafx* \
            lib/*jfx* \
            lib/amd64/libdecora_sse.so \
            lib/amd64/libprism_*.so \
            lib/amd64/libfxplugins.so \
            lib/amd64/libglass.so \
            lib/amd64/libgstreamer-lite.so

# This will be used as the REPL port
EXPOSE 21212

ENV LEIN_ROOT 1

# Install Clojure
RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /bin/lein && \
    chmod u+x /bin/lein && \
    lein && \
    lein repl

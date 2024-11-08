FROM quay.io/phasetwo/phasetwo-keycloak:26.0.5

ENV KC_FEATURES="token-exchange"
ENV KC_FEATURES_DISABLED="multi-site"
ENV KC_CACHE="ispn"
ENV KC_CACHE_STACK="kubernetes"

ENV JAVA_OPTS="-Djgroups.dns.query=keycloak-svc-headless"
ENV KC_DB="postgres"

ENV KC_HTTP_ENABLED="true"
ENV KC_HOSTNAME_STRICT="true"
ENV KC_HOSTNAME_STRICT_BACKCHANNEL="true"
ENV DISABLE_EXTERNAL_ACCESS="true"
ENV KC_PROXY_HEADERS="forwarded"

RUN /opt/keycloak/bin/kc.sh build --metrics-enabled=true --health-enabled=true

WORKDIR /opt/keycloak

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--log-console-output=json", "--optimized", "--spi-email-template-provider=freemarker-plus-mustache", "--spi-email-template-freemarker-plus-mustache-enabled=true", "--spi-theme-cache-themes=false"]

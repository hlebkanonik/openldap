FROM osixia/openldap:1.5.0
LABEL maintainer="hleb_kanonik@epam.com"
COPY ./assets/ /container/service/slapd/assets/config/bootstrap/ldif/
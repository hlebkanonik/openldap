FROM osixia/openldap:latest
LABEL maintainer="hleb_kanonik@epam.com"
COPY ./assets/ /container/service/slapd/assets/config/bootstrap/ldif/
FROM bitnami/openldap:latest
COPY pbkdf2.ldif /opt/bitnami/openldap/etc/schema/
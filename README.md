# OpenLDAP for ReportPortal testing

This document provides a step-by-step guide on setting up OpenLDAP for local testing of ReportPortal. OpenLDAP is an open-source implementation of the Lightweight Directory Access Protocol (LDAP) that allows you to simulate a directory service locally. By using OpenLDAP, you can create and manage user accounts and groups, which are essential for testing user authentication and authorization in ReportPortal.


## Prerequisites

Tested on:
1. Docker 25.0.0
2. Docker Compose 2.24.2

Before deployment, you have to change the default user in the `./assets/02-default-users.ldif` file.

## Deployment

### Deploy with Docker Compose

1. Run Docker Compose to start the containers:
```bash
docker compose -p reportportal up -d
```

## Configure OPEN LDAP plugin in ReportPortal

Login as `superadmin` in ReportPortal and open `administrate` -> `plugins` -> `installed`, choose OPNLDAP plugin. 

1. Url: `openladp:389`
2. Base DN: `dc=reportportal,dc=io`
3. Manager DN: `cn=admin,dc=reportportal,dc=io`
4. Manager password: `rpadminpass`

## Login to phpLDAPadmin

phpLDAPadmin is a web-based administration tool that simplifies the management of LDAP servers through an intuitive interface

Open in browser `http://localhost:8081` and login:

1. Login DN: `cn=admin,dc=reportportal,dc=io`
2. Password: `rpadminpass`

## Uninstalling Docker Compose

```bash
docker compose down && docker volume rm openldap_openldap_data
```


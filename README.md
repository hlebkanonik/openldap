# OpenLDAP for ReportPortal testing

This document provides a step-by-step guide on setting up OpenLDAP for local testing of ReportPortal. OpenLDAP is an open-source implementation of the Lightweight Directory Access Protocol (LDAP) that allows you to simulate a directory service locally. By using OpenLDAP, you can create and manage user accounts and groups, which are essential for testing user authentication and authorization in ReportPortal.


## Prerequisites

Before proceeding with the setup, ensure that you have the following prerequisites in place:

1. Docker v23.0.5
2. Docker Compose v2.17
3. ReportPortal v5+

Before deployment, you can change the default user in the `./assets/02-default-users.ldif` file.

## Deployment

### Step 1. Deploy Docker Compose

1. Clone the Git repository using the `git clone` command
2. Navigate to the cloned repository's directory using the `cd` command 
```bash
cd openldap
```
3. Run Docker Compose to start the containers:
```bash
docker compose -p reportportal up -d
```
> This command will use the `docker-compose.yml` file in the current directory to set up and start the containers. The `-p reportportal` flag sets a custom project name for the Docker Compose stack, and the `-d` flag runs the containers in the background.


## Step 2. Configure OPEN LDAP plugin in ReportPortal

Login as `superadmin` in ReportPortal URL and open `administrate/plugins/installed`, choose OPNLDAP plugin. 

1. Url: `openladp:389`
2. Base DN: `dc=rp,dc=com`
3. Manager DN: `cn=admin,dc=rp,dc=com`
4. Manager password: `rpadminpass`

If LDAP users have problems logging into the Report Portal, deploy the application by `docker compose -p reportportal up -d --force-recreate`.

## Step 3. Login to phpLDAPadmin

phpLDAPadmin is a web-based administration tool that simplifies the management of LDAP servers through an intuitive interface

Open in browser `https://localhost:6443` and login:

1. Login DN: `cn=admin,dc=rp,dc=com`
2. Password: `rpadminpass`

## Step 4. Removal

```bash
docker stop phpldapadmin-service openldap && docker rm phpldapadmin-service openldap
```

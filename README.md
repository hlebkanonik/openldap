# Automatic Installation
To install ReportPortal OPENLDAP and MYPHPLDAPADMIN use next commands:
```bash
cd openldap/
chmod +x install.sh
./install.sh
```

# Manual installation

## Step 1. Build the docker OPENLDAP image
```bash
docker build . -t openldap-rp:0.1.2
```

## Step 2. Run container with OPENLDAP
```bash
docker-compose up -d
```

## Checks
- Locally
```bash
ldapsearch -x -H ldap://localhost -b dc=rp,dc=com -D "cn=admin,dc=rp,dc=com" -w rpadminpass
```
- With Docker
```bash
docker exec openldap ldapsearch -x -H ldap://localhost -b dc=rp,dc=com -D "cn=admin,dc=rp,dc=com" -w rpadminpass
```

## Step 3. Configure OPEN LDAP plugin in ReportPortal
Login as `superadmin` in ReportPortal URL and open `administrate/plugins/installed`, choose OPNLDAP plugin. 

Settings list:

1. URL
```bash
OPENLDAP_HOST=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' openldap)
echo $OPENLDAP_HOST:389
```
2. Base DN: `dc=rp,dc=com`
3. Manager DN: `cn=admin,dc=rp,dc=com`
4. Manager password: `rpadminpass`

All settings from docker-compose/environment

## Step 4. Configure PHPLDAPADMIN
Environment variable:

```bash
OPENLDAP_HOST=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' openldap)
```

Create PHPLDAPADMIN container:
```bash
docker run -p 6443:443 --name phpldapadmin-service \
           --hostname phpldapadmin-service --link openldap --env PHPLDAPADMIN_LDAP_HOSTS=$OPENLDAP_HOST \
           --network=reportportal-default --detach osixia/phpldapadmin:0.9.0
```
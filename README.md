## Step 1. Build the docker image
```bash
docker build . -t openldap-rp:0.1.2
```

## Step 2. Run service
```bash
docker-compose up -d
```

## Step 3. Check 
- Localy
```bash
ldapsearch -x -H ldap://localhost -b dc=rp,dc=com -D "cn=admin,dc=rp,dc=com" -w rpadminpass
```
- Docker
```bash
docker exec openldap ldapsearch -x -H ldap://localhost -b dc=rp,dc=com -D "cn=admin,dc=rp,dc=com" -w rpadminpass
```

## Configurate OPENLDAP plugin
Insert into the ldap host field the internal ip of the container.
```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' openldap
```

# OpenLDAP for ReportPortal Testing

This document provides a step-by-step guide on setting up OpenLDAP for local testing of ReportPortal. OpenLDAP is an open-source implementation of the Lightweight Directory Access Protocol (LDAP), which allows you to simulate a directory service locally. By using OpenLDAP, you can create and manage user accounts and groups that are essential for testing user authentication and authorization in ReportPortal.

## Prerequisites

Before proceeding with the setup, ensure that the following prerequisites are met:

1. Docker 20.10 or higher
2. Docker Compose 1.27.4 or higher
3. ReportPortal v5 or higher

## Deployment

To deploy OpenLDAP, execute the following command with Docker Compose:

```bash
docker-compose up -d
```

## ReportPortal Integration

To integrate OpenLDAP with ReportPortal, follow these steps:

1. Login as `superadmin` to ReportPortal.
2. Click on **Superadmin** icon in the left sidebar.
3. Open **Plugins** and click on the **Installed** tab.
4. Select **LDAP** plugin and fill in the following details:
   - Url: `ldap://openladp:389`
   - Base DN: `dc=example,dc=com`
   - Manager DN: `cn=admin,dc=example,dc=com`
   - Manager password: `mypassword123`
   - User search filter: `uid={0}`
   - Password encoder type: `NO`
   - Email attribute: `mail`
   - Full name attribute: `cn`
   - Photo attribute: `photo`
5. Exit from Reportportal and Login back with the LDAP user credentials.

## PBKDF2-SHA256 encryption configuration

To enable password encryption, follwo these steps:

1. Get the encrypted password by running the following command:

```bash
PBKDF2_PSW=$(docker exec openldap slappasswd -o module-load=/opt/bitnami/openldap/libexec/openldap/pw-pbkdf2.so -h {PBKDF2-SHA256} -s "mypassword")
echo "Your password is: ${PBKDF2_PSW}"
```

Encription algoritm can be changed by changing the `-h` parameter. For example, to use `PBKDF2-SHA512` algorithm, replace `-h {PBKDF2-SHA256}` with `-h {PBKDF2-SHA512}`.

2. Modife user password with encrypted password:

```bash
cat <<EOF > /tmp/mod_user.ldif
dn: cn=alice,ou=users,dc=example,dc=com
changetype: modify
replace: userPassword
userPassword: ${PBKDF2_PSW}
EOF

docker cp /tmp/mod_user.ldif openldap:/tmp/mod_user.ldif
```

3. Apply the changes:

```bash
docker exec openldap ldapmodify -x -D "cn=admin,dc=example,dc=com" -w mypassword123 -H ldap://localhost -f /tmp/mod_user.ldif
```

4. Verify the changes:

```bash
docker exec openldap ldapwhoami -vvv -D cn=alice,ou=users,dc=example,dc=com -x -w 'mypassword'
```

Reponces should be like this:

```bash
ldap_initialize( <DEFAULT> )
dn:cn=alice,ou=users,dc=example,dc=com
Result: Success (0)
```
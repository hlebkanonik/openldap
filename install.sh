# install OPENLDAP for ReportPortal
cd Dockerfile
docker build . -t openldap-rp:0.1.2

cd ..
docker-compose up -d

OPENLDAP_HOST=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' openldap)

echo "####### CONFIG FOR REPORTPORTAL #######\n## URL: 172.21.0.2:389               ##\n\
## Base DN: dc=rp,dc=com             ##\n## Manager DN: cn=admin,dc=rp,dc=com ##\n\
## Manager password: rpadminpass     ##\n#######################################"

docker run -p 6443:443 --name phpldapadmin-service \
           --hostname phpldapadmin-service --link openldap --env PHPLDAPADMIN_LDAP_HOSTS=$OPENLDAP_HOST \
           --network=reportportal-default --detach osixia/phpldapadmin:0.9.0

echo "############### PHPOPENLDAPADMIN ################\n## Open URL in browser: https://localhost:6443 ##\n\
## Login DN:: cn=admin,dc=rp,dc=com            ##\n## Password: rpadminpass                       ##\n\
#################################################"
echo "\n\nTo uninstall use the command:\ndocker stop phpldapadmin-service openldap && docker rm phpldapadmin-service openldap"
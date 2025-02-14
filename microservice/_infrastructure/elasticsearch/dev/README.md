# Reset Password
\$ docker exec -it echovibe-elasticsearch-i1 /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic

# Generate Token
\$ docker exec -it echovibe-elasticsearch-i1 /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana

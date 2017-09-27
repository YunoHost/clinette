#!/bin/bash

COMMAND=$1
DOMAIN=$2

DYNHOST_USER="yunohost"
DYNHOST_HOST="bearnaise.yunohost.org"
DYNHOST_PORT="2210"


check_domain() {
    if [ -z "$DOMAIN" ]; then
        echo "[ERROR] You must provide a domain"
        exit 1
    fi
}

domain_test() {
    check_domain
    echo "Testing domain <$DOMAIN>"

    RESULT=$(ssh $DYNHOST_USER@$DYNHOST_HOST -p $DYNHOST_PORT curl "dyndns.yunohost.org/test/$DOMAIN" -s -o -)
    echo $RESULT
}

domain_delete() {
    check_domain
    echo "Delete domain <$DOMAIN>"

    RESULT=$(ssh $DYNHOST_USER@$DYNHOST_HOST -p $DYNHOST_PORT curl -X DELETE "dyndns.yunohost.org/domains/$DOMAIN" -s -o -)
    echo $RESULT
}

case "$COMMAND" in
    test)
        domain_test
        ;;
     
    delete)
        domain_delete
        ;;
     
    *)
        echo $"Usage: $0 {test|delete} <domain>"
        exit 1

esac
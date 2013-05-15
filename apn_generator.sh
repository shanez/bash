TEMP_CERT_PEM=/tmp/Cert.pem
TEMP_KEY=/tmp/Key.pem
TEMP_NO_ENCODING=/tmp/CertNoEncoding.pem

# http://www.raywenderlich.com/3443/apple-push-notification-services-tutorial-part-12

if [ -z "$3" ]
then
  echo "
       Generates a push cert
       (Keep all your passwords the same as you will be asked multiple times for each key) 

        \$1 = Path to push cert downloaded from apple
        \$2 = Path to private key (exported from keychain) 
             used to generate push cert
        \$3 = Path to output file
"
else
  openssl x509 -in "$1" -inform der -out $TEMP_CERT_PEM
  openssl pkcs12 -nocerts -out $TEMP_KEY -in "$2"
  openssl rsa -in $TEMP_KEY -out $TEMP_NO_ENCODING
  cat $TEMP_CERT_PEM $TEMP_NO_ENCODING > $3
fi

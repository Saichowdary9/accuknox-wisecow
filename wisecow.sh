#!/usr/bin/env bash

SRVPORT=4499
RSPFILE=response

rm -f $RSPFILE
mkfifo $RSPFILE

get_api() {
    read line
    echo $line
}

handleRequest() {
    # Process the request
    get_api
    mod=$(fortune | cowsay)

cat <<EOF > $RSPFILE
HTTP/1.1 200 OK
Content-Type: text/html

<pre>$mod</pre>
EOF
}

prerequisites() {
    command -v cowsay >/dev/null 2>&1 &&
    command -v fortune >/dev/null 2>&1 ||
    {
        echo "Install prerequisites."
        exit 1
    }
}

main() {
    prerequisites
    echo "Wisdom served on port=$SRVPORT..."

    while true; do
        cat $RSPFILE | nc -l -p $SRVPORT -q 1 | handleRequest
        sleep 0.01
    done
}

main
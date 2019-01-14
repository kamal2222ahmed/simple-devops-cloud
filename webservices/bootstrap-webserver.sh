#!/bin/bash
set -euo pipefail
echo "Successfully Bootstrapped" > index.html
nohup busybox httpd -fp 80 &
#!/bin/bash

find . -type f -name "*.tf" -exec dirname {} \;|sort -u | while read m; do (terraform validate -check-variables=false "$m" && echo "√ $m") || exit 1 ; done

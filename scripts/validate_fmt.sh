#!/bin/bash

if [ `terraform fmt --list=true -diff=true -write=false | tee format-issues | wc -c` -ne 0 ]; then
  echo "Some terraform files need be formatted, run 'terraform fmt' to fix"
  echo "Formatting issues:"
  cat format-issues
  exit 1
fi

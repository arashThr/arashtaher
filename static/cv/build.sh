#!/bin/bash

# Use this script for generating the HTML version of the resume
# Don't forget to update Email and Phone number before printing

pandoc cv.md \
  --from markdown \
  --to html5 \
  --template=template.html \
  --css=style.css \
  -s -o index.html

echo "✅ CV generated: index.html — open in browser to print to PDF"

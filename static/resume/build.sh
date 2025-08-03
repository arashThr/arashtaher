#!/bin/bash

# Use this script for generating the HTML version of the resume
# Don't forget to update Email and Phone number before printing

pandoc resume.md \
  --from markdown \
  --to html5 \
  --template=template.html \
  --css=style.css \
  -s -o arashtaher.html

echo "✅ Resume generated: resume.html — open in browser to print to PDF"

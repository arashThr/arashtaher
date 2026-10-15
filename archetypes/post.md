+++
title = '{{ replace (replaceRE `^[0-9]{4}-[0-9]{2}-[0-9]{2}-` "" .File.ContentBaseName) `-` ` ` | title }}'
date = '{{ .Date }}'
draft = true
slug = '{{ replaceRE `^[0-9]{4}-[0-9]{2}-[0-9]{2}-` "" .File.ContentBaseName }}'
tags = []
+++

SHELL := /bin/bash
.DEFAULT_GOAL := help

# Optional. When set, replaces the generated title.
export title

# The slug is the first argument that is not a target: make til my-note
KNOWN := help post til essay section check-name apply-title
EXTRA := $(filter-out $(KNOWN),$(MAKECMDGOALS))
name := $(or $(name),$(firstword $(EXTRA)))

ifneq ($(word 2,$(EXTRA)),)
$(error Pass one slug, for example: make til my-note)
endif

ifneq ($(EXTRA),)
$(EXTRA):
	@:
endif

.PHONY: help post til essay section check-name apply-title

help:
	@printf '%s\n' \
		'Create a draft. The first argument is the URL slug: lowercase words with hyphens.' \
		'Optional title= sets the title. Fields are documented in archetypes/README.md.' \
		'' \
		'  make post my-post [title="My Post"]' \
		'  make til my-note [title="My Note"]' \
		'  make essay my-essay [title="My Essay"]' \
		'  make section garden [title="Garden"]'

check-name:
	@if [[ -z "$(name)" ]]; then \
		echo "Pass a slug. Example: make $(firstword $(MAKECMDGOALS)) my-note"; \
		exit 1; \
	fi
	@if [[ ! "$(name)" =~ ^[a-z0-9]+(-[a-z0-9]+)*$$ ]]; then \
		echo "name must be lowercase words separated by hyphens, like my-note"; \
		exit 1; \
	fi

define APPLY_TITLE_PY
import os, pathlib, re, sys
title = os.environ.get("title", "")
path = sys.argv[1]
if not title:
    raise SystemExit(0)
if not path:
    raise SystemExit("apply-title needs file=")
text = pathlib.Path(path).read_text()
escaped = title.replace("\\", "\\\\").replace('"', '\\"')
updated, n = re.subn(r"(?m)^title = .*$$", 'title = "' + escaped + '"', text, count=1)
if n != 1:
    raise SystemExit("title line not found in " + path)
pathlib.Path(path).write_text(updated)
endef
export APPLY_TITLE_PY

apply-title:
	@printf '%s\n' "$$APPLY_TITLE_PY" | python3 - "$(file)"

post: check-name
	@file="content/blog/$$(date +%F)-$(name).md"; \
	hugo new content --kind post "$$file" && \
	$(MAKE) --no-print-directory apply-title file="$$file"

til: check-name
	@if [[ "$(name)" == "tils" || "$(name)" == "essays" ]]; then \
		echo "tils and essays are reserved for the filter pages"; \
		exit 1; \
	fi
	@file="content/aie/$(name).md"; \
	hugo new content --kind til "$$file" && \
	$(MAKE) --no-print-directory apply-title file="$$file"

essay: check-name
	@if [[ "$(name)" == "tils" || "$(name)" == "essays" ]]; then \
		echo "tils and essays are reserved for the filter pages"; \
		exit 1; \
	fi
	@file="content/aie/$(name).md"; \
	hugo new content --kind essay "$$file" && \
	$(MAKE) --no-print-directory apply-title file="$$file"

section: check-name
	@if [[ -e "content/$(name)" || -e "content/$(name).md" ]]; then \
		echo "content/$(name) already exists"; \
		exit 1; \
	fi
	@file="content/$(name)/_index.md"; \
	hugo new content --kind section "$$file" && \
	$(MAKE) --no-print-directory apply-title file="$$file"

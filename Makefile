#!/bin/bash

# Run the project on port 4000
.PHONY: run-dev
run-dev:
	bin/rails server -p 4000

.PHONY: test-all
test-all:
	bundle exec bundle-audit && bundle exec rspec && bundle exec rubocop

# Make a database snapshot
snapshot:
	pg_dump --no-acl --no-owner --clean dsel_$(ENV) | gzip > dsel_$(ENV)`date -u +'%Y-%m-%dT%H-%M-%SZ'`.sql.gz
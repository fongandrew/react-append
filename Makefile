# Phone so pkg dir targets actually do something
.PHONY: default setup clean build lint test

# Put Node bins in path
export PATH := node_modules/.bin:$(PATH)
export SHELL := /bin/bash

default: build

setup:
	yarn install

clean:
	rm -rf lib
	$(MAKE) -C example clean
	
build: clean
	tsc -p tsconfig.build.json

lint:
	tslint --type-check --project tsconfig.json
	$(MAKE) -C example lint

watch:
	$(MAKE) -C example watch

test:
	ts-node --project tsconfig.test.json \
		node_modules/.bin/tape \
			-r './test-helpers/setup-dom.ts' \
			'src/**/*.test.*' | tap-spec
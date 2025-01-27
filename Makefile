PREFIX ?= /usr/local
VERSION ?= $(shell git describe --tags --dirty --always | sed -e 's/^v//')

.PHONY: build
build:
	go build -ldflags="-X main.version=$(VERSION)" -o dist/local/mod

.PHONY: install
install: build
	@cp dist/local/mod $(PREFIX)/bin/mod
	@chmod 755 $(PREFIX)/bin/mod
	@mod --version

.PHONY: lint-go
lint-go:
	golangci-lint run

.PHONY: lint
lint: lint-go

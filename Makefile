export GOPATH = $(PWD)

.PHONY: all
all: bin/vgo bin/acme

bin:
	mkdir bin

bin/vgo: | bin
	go get -u -v golang.org/x/vgo

bin/acme: src/acme/cmd/acme/main.go | bin
	cd $(^D) && go build -o acme-go # Get a baseline
	cd $(^D) && vgo build -o acme-vgo

src/acme/cmd/acme/main.go: src/acme
	mkdir -p $(@D)
	cp main.go $(@)

src/acme: src/github.com/coreos/etcd
	mkdir -p $(@)
	git -C $(@) init
	touch $(@)/go.mod

src/github.com/coreos/etcd:
	mkdir -p $(@D)
	git -C $(@D) clone https://github.com/coreos/etcd.git
	git -C $(@) checkout tags/v3.3.7
	go get github.com/gogo/protobuf/gogoproto
	go get github.com/golang/protobuf/proto

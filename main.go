package main

import (
	"fmt"

	"github.com/coreos/etcd/raft"
)

func main() {
	_ = raft.NewMemoryStorage()
	fmt.Println("Project compiled")
}

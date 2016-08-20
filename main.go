// main is main !
package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"

	_ "net/http/pprof"
)

func main() {
	http.HandleFunc("/", hello)

	port := os.Getenv("APP_PORT")
	log.Println(fmt.Sprintf("Serving on port '%s'.", port))

	log.Fatal(http.ListenAndServe(":"+port, nil))
}

func hello(w http.ResponseWriter, r *http.Request) {
	hash := strings.Split(r.URL.Path, "/")

	if len(hash) == 3 && hash[1] == "hello" {
		fmt.Fprintf(w, "Hello, %s !", hash[2])
		return
	}

	http.Error(w, http.StatusText(http.StatusNotFound), http.StatusNotFound)
}

// main is main !
package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	_ "net/http/pprof"

	"github.com/julienschmidt/httprouter"
)

func hello(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {
	fmt.Fprintf(w, "Hello %s, you have a project named %s on %s !",
		ps.ByName("username"),
		ps.ByName("project"),
		ps.ByName("domain"),
	)
}

func main() {
	router := httprouter.New()
	router.GET("/:domain/:username/:project", hello)

	port := os.Getenv("APP_PORT")
	log.Println(fmt.Sprintf("Serving on port '%s'.", port))

	log.Fatal(http.ListenAndServe(":"+port, router))
}

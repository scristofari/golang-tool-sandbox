package main

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/julienschmidt/httprouter"
)

func TestHello(t *testing.T) {
	req, _ := http.NewRequest(
		http.MethodGet,
		"",
		nil,
	)
	ps := httprouter.Params{
		httprouter.Param{
			Key:   "project",
			Value: "golang-poll",
		},
		httprouter.Param{
			Key:   "domain",
			Value: "github.com",
		},
		httprouter.Param{
			Key:   "username",
			Value: "scristofari",
		},
	}
	rec := httptest.NewRecorder()

	hello(rec, req, ps)

	if rec.Code != http.StatusOK {
		t.Errorf("Expected 200, get %d", rec.Code)
	}
	if rec.Body.String() != "Hello scristofari, you have a project named golang-poll on github.com !" {
		t.Error("Unexpected body")
	}
}

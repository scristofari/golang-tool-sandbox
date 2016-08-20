package main

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestHello(t *testing.T) {

	cases := []struct {
		in, out string
		code    int
	}{
		{"http://localhost:8080/hello/scristofari", "Hello, scristofari !", 200},
		{"http://localhost:8080/whatelse", "Not Found", 404},
	}

	for _, c := range cases {
		req, _ := http.NewRequest(
			http.MethodGet,
			c.in,
			nil,
		)

		rec := httptest.NewRecorder()

		hello(rec, req)

		if rec.Code != c.code {
			t.Errorf("Expected %d, get %d", c.code, rec.Code)
		}

		body := strings.TrimSpace(rec.Body.String())
		if body != c.out {
			t.Errorf("Unexpected body, expected %s, got %s", c.out, body)
		}
	}
}

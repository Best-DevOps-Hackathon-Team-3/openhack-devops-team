package tripsgo

import (
	"encoding/json"
	"net/http"
)

func healthcheckGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)

	hc := &Healthcheck{Message: "Trip Service Healthcheck", Status: "This is a test message."}

	json.NewEncoder(w).Encode(hc)
}

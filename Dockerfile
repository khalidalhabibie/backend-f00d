FROM golang:1.17-alpine AS builder

LABEL maintainer="Khalid Alhabibie <khalidalhabibie07@gmail.com>"

# Move to working directory (/build).
WORKDIR /build

# Copy and download dependency using go mod.
COPY go.mod go.sum ./
RUN go mod download

# Copy the code into the container.
COPY . .

# Set necessary environment variables needed for our image and build the API server.
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
RUN go build -ldflags="-s -w" -o apiserver .

FROM heroku/heroku:16

# Copy binary and config files from /build to root folder of scratch container.
COPY --from=builder ["/build/apiserver", "/build/.env", "/"]

# Command to run when starting the container.
CMD ["/apiserver"]
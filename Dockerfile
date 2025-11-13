# Build stage
FROM golang:1.21-alpine AS builder
WORKDIR /app
RUN apk add --no-cache git build-base
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o server ./cmd/server/main.go

FROM alpine:3.18
WORKDIR /app
RUN apk add --no-cache ca-certificates bash
COPY --from=builder /app/server ./server
COPY migrations ./migrations
COPY .env .env
EXPOSE 8080
CMD ["./server"]


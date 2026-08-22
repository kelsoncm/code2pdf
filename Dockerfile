FROM rust:1.75-alpine AS builder

RUN apk add --no-cache musl-dev
RUN cargo install code-to-pdf



FROM alpine:3.19
COPY --from=builder /usr/local/cargo/bin/c2pdf /usr/local/bin/c2pdf

# Instalar git para suporte a .gitignore (opcional)
RUN apk add --no-cache git

WORKDIR /code
ENTRYPOINT ["c2pdf"]
CMD ["."]

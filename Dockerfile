# Build stage
FROM rust:1.98-slim AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends pkg-config libfontconfig1-dev \
    && cargo install code-to-pdf --locked

# Runtime stage
FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends libfontconfig1 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/cargo/bin/c2pdf /usr/local/bin/c2pdf

WORKDIR /code
ENTRYPOINT ["/usr/local/bin/c2pdf"]
CMD ["."]

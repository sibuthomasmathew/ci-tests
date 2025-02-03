# Use a minimal base image
FROM alpine:latest as builder

# Set working directory
WORKDIR /app

# Install required utilities (curl, tar)
RUN apk add --no-cache curl tar

ARG VERSION

# Download the tar file and extract it
RUN curl -L -O https://github.com/sibuthomasmathew/golang-web-apps/releases/download/${VERSION}/web-app.tar.gz \
    && tar -xzvf web-app.tar.gz \
    && rm -f web-app.tar.gz  # Clean up

FROM debian:bookworm-slim

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/web-app /app/web-app

# Run the web service on container startup.
CMD ["/app/web-app"]

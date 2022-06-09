FROM debian:10-slim

RUN DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install -y img2pdf && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["img2pdf"]
CMD ["--help"]

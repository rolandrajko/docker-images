FROM alpine:3.14
RUN apk --no-cache add dnsmasq
EXPOSE 53/tcp 53/udp
CMD ["dnsmasq", "--no-daemon"]

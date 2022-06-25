# Dnsmasq

It's a small [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) image.

## Usage

In production it is usually a good idea to use a tag other than `latest`. There are currently tags below to choose from:

* `rolandrajko/dnsmasq:latest`: dnsmasq 2.86 based on Alpine 3.16
* `rolandrajko/dnsmasq:2.85`: dnsmasq 2.85 based on Alpine 3.14
* `rolandrajko/dnsmasq:2.84`: dnsmasq 2.84 based on Alpine 3.13
* `rolandrajko/dnsmasq:2.80`: dnsmasq 2.80 based on Alpine 3.9

Dnsmasq requires `NET_ADMIN` capabilities to run correctly:
```
docker run -p 53:53/tcp -p 53:53/udp --cap_add=NET_ADMIN rolandrajko/dnsmasq:latest
```
If you wanna set options, you can do like this:
```
docker run --name dnsmasq -d -p 53:53/tcp -p 53:53/udp --cap_add=NET_ADMIN rolandrajko/dnsmasq:latest dnsmasq --no-daemon --no-resolv --server=1.1.1.1 --address=/example.com/127.0.0.1 --no-negcache
```

FROM alpine:3.11.3 AS build

ARG terraform_version=0.12.20
ARG uid=1000
ARG gid=1000

WORKDIR /app

RUN addgroup -g ${gid} terraform \
 && adduser -u ${uid} -s /bin/sh -S terraform \
 && mkdir -p /app \
 && chown -R terraform:terraform /app \
 && wget https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip -O terraform.zip \
 && unzip terraform.zip \
 && apk --no-cache add ca-certificates

FROM scratch

WORKDIR /app

COPY --from=build /etc/ssl/certs /etc/ssl/certs
COPY --from=build /etc/passwd /etc/group /etc/shadow /etc/
COPY --from=build --chown=terraform:terraform /tmp /tmp
COPY --from=build --chown=terraform:terraform /app/terraform /bin/terraform

USER terraform

ENTRYPOINT ["terraform"]

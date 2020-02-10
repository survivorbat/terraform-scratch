ARG alpine_version=3.11.3

FROM alpine:${alpine_version} AS alpine

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
 && apk --no-cache add \
   ca-certificates \
   curl

USER terraform

ENTRYPOINT ["terraform"]

FROM scratch

WORKDIR /app

COPY --from=alpine /etc/ssl/certs /etc/ssl/certs
COPY --from=alpine /etc/passwd /etc/group /etc/shadow /etc/
COPY --from=alpine --chown=terraform:terraform /tmp /tmp
COPY --from=alpine --chown=terraform:terraform /app/terraform /bin/terraform

USER terraform

ENTRYPOINT ["terraform"]

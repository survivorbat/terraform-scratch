# Terraform Image

![Docker Pulls](https://img.shields.io/docker/pulls/survivorbat/terraform-scratch)

This repository contains a relatively simple Dockerfile to build a small but practical docker container containing the terraform
framework.

It also possesses an alpine-variant that contains Ansible binaries to use in a local_exec.

## Prerequisites

You'll need Docker installed to use this image.
In case you wish to work on developing this image further, it's advisable to also have Make installed to utilise the Makefile.

## Getting started

Using this image is as simple as running `docker run -it --rm -v $(pwd):/app survivorbat/terraform-scratch plan`.

### Development

This image can be build locally using `make build`.

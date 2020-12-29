
ARG DISK_IMAGE_URL
FROM alpine AS download
ARG DISK_IMAGE_URL
RUN apk add curl 
RUN curl -L $DISK_IMAGE_URL -o disk-image.qcow2

LABEL maintainer="https://github.com/jseguillon/kubevirt-images"
FROM kubevirt/registry-disk-v1alpha

COPY --from=download disk-image.qcow2 /disk

ARG DISK_IMAGE_URL
ARG CHECKSUM_URL
FROM alpine AS download
ARG DISK_IMAGE_URL
ARG CHECKSUM_URL
RUN apk add curl 
RUN curl -L $DISK_IMAGE_URL -o ${DISK_IMAGE_URL##*/} \
  && curl -L $CHECKSUM_URL -o ${CHECKSUM_URL##*/} \
  && grep $(sha256sum ${DISK_IMAGE_URL##*/}) ${CHECKSUM_URL##*/} \
  && mv ${DISK_IMAGE_URL##*/} disk-image.qcow2

LABEL maintainer="https://github.com/jseguillon/kubevirt-images"
FROM kubevirt/registry-disk-v1alpha

COPY --from=download disk-image.qcow2 /disk
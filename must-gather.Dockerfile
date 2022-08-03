# Build the manager binary
FROM registry.access.redhat.com/ubi8/ubi:8.5 as builder
WORKDIR /opt/app-root/src
RUN curl https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz | tar xz oc

# Use UBI8 Micro as minimal base image to package the manager binary
# Refer to https://www.redhat.com/en/blog/introduction-ubi-micro for more details
FROM registry.access.redhat.com/ubi8/ubi-micro:8.5
ARG VERSION
ENV VERSION=$VERSION
COPY --from=builder /opt/app-root/src/oc /usr/bin/oc
COPY --from=builder /usr/bin/tar /usr/bin/tar
COPY must-gather/gather* /usr/bin/

ENTRYPOINT ["/bin/bash"]

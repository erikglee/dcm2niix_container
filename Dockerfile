# syntax=docker/dockerfile:1

FROM debian:bookworm-slim AS builder

ARG DCM2NIIX_VERSION=v1.0.20260724

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        build-essential \
        ca-certificates \
        cmake \
        git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

# Build from the requested upstream release tag.  Building source supports both
# linux/amd64 and linux/arm64 through Docker Buildx.
RUN git clone --branch "${DCM2NIIX_VERSION}" --depth 1 \
        https://github.com/rordenlab/dcm2niix.git \
    && cmake -S dcm2niix -B dcm2niix/build \
        -DCMAKE_BUILD_TYPE=Release \
        -DZLIB_IMPLEMENTATION=zlib-ng \
        -DUSE_JPEGLS=ON \
        -DUSE_OPENJPEG=GitHub \
    && cmake --build dcm2niix/build --parallel

FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="dcm2niix" \
      org.opencontainers.image.description="Convert DICOM images to NIfTI" \
      org.opencontainers.image.source="https://github.com/rordenlab/dcm2niix" \
      org.opencontainers.image.version="v1.0.20260724"

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        ca-certificates \
        libgcc-s1 \
        libstdc++6 \
        pigz \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/dcm2niix/build/bin/dcm2niix /usr/local/bin/dcm2niix

WORKDIR /data

ENTRYPOINT ["dcm2niix"]
CMD ["--help"]

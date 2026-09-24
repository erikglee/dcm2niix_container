# dcm2niix_container

Container image for [dcm2niix](https://github.com/rordenlab/dcm2niix), built from
upstream release `v1.0.20260724` (24 July 2026).

## Use

Build locally:

```sh
docker build -t dcm2niix:v1.0.20260724 .
```

`dcm2niix` is the image entrypoint. Mount an input/output directory and pass its
usual options directly:

```sh
docker run --rm -v "$PWD:/data" dcm2niix:v1.0.20260724 -z y -o /data/output /data/dicom
```

The image’s default command is `--help`.

## Pull a published image

Published images are available from GitHub Container Registry at
`ghcr.io/erikglee/dcm2niix_container`. Pull the release image with Docker:

```sh
docker pull ghcr.io/erikglee/dcm2niix_container:v1.0.20260724
docker run --rm -v "$PWD:/data" ghcr.io/erikglee/dcm2niix_container:v1.0.20260724 \
  -z y -o /data/output /data/dicom
```

Or pull it as an Apptainer image and run the same command:

```sh
apptainer pull dcm2niix.sif docker://ghcr.io/erikglee/dcm2niix_container:v1.0.20260724
apptainer run --bind "$PWD:/data" dcm2niix.sif -z y -o /data/output /data/dicom
```

Replace the release tag with `latest` if you want the image built from the most
recent commit to `main`. If the GHCR package is private, authenticate to GHCR
with a GitHub personal access token that has `read:packages` permission before
pulling.

## Publishing

GitHub Actions builds Linux `amd64` and `arm64` images for pull requests, pushes
to `main`, version tags, and manual runs. Non-PR builds publish to GitHub Container
Registry as `ghcr.io/<owner>/<repository>`. Ensure the repository Actions setting
allows workflows to create and write packages.

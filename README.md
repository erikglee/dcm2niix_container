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

## Publishing

GitHub Actions builds Linux `amd64` and `arm64` images for pull requests, pushes
to `main`, version tags, and manual runs. Non-PR builds publish to GitHub Container
Registry as `ghcr.io/<owner>/<repository>`. Ensure the repository Actions setting
allows workflows to create and write packages.

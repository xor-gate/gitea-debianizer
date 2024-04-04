#!/usr/bin/env bash
GITEA_VERSION=$(cat debpkg.yml | sed -n "s/^version: \(.*\)$/\1/p")
BUILD_DIR=build
DEBPKG=$HOME/go/bin/debpkg

set -e

GITHUB_GITEA_DL_BASE_URL="https://github.com/go-gitea/gitea/releases/download/v${GITEA_VERSION}/"
GITEA_XZ_RELEASE_URL="${GITHUB_GITEA_DL_BASE_URL}/gitea-${GITEA_VERSION}-linux-amd64.xz"
GITEA_TARGZ_DOCS_URL="${GITHUB_GITEA_DL_BASE_URL}/gitea-docs-${GITEA_VERSION}.tar.gz"
GITEA_XZ_OUTFILE="${BUILD_DIR}/gitea.xz"
GITEA_TARGZ_DOCS_OUTFILE="${BUILD_DIR}/gitea-docs.tar.gz"
GITEA_EXE="${BUILD_DIR}/gitea"
GITEA_DEB_FILE="${BUILD_DIR}/gitea-${GITEA_VERSION}-amd64.deb"

mkdir -v -p ${BUILD_DIR}
if [ ! -f "${GITEA_EXE}" ]; then
	echo "[RUN] Downloading and unpacking Gitea executable from ${GITEA_XZ_RELEASE_URL}"
	curl --location -o ${GITEA_XZ_OUTFILE} ${GITEA_XZ_RELEASE_URL}
	unxz ${GITEA_XZ_OUTFILE}
else
	echo "[SKIP] Download and unpack gitea executable"
fi

if [ ! -f "${GITEA_TARGZ_DOCS_OUTFILE}" ]; then
	echo "[RUN] Download and unpack gitea docs from ${GITEA_TARGZ_DOCS_URL}"
	curl --location -o ${GITEA_TARGZ_DOCS_OUTFILE} ${GITEA_TARGZ_DOCS_URL}
	tar -xf ${GITEA_TARGZ_DOCS_OUTFILE}
else
	echo "[SKIP] Docs already downloaded and unpacked"
fi

if [ ! -f "${GITEA_DEB_FILE}" ]; then
	echo "[RUN] debianize with debpkg"
	${DEBPKG} -o ${GITEA_DEB_FILE}
else
	echo "[SKIP] debianize with debpkg as ${GITEA_DEB_FILE} exists"
fi

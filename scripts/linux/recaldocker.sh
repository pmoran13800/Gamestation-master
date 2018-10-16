#!/bin/bash

# Quick'n'dirty checks
if [[ -z "$ARCH" ]] ; then
  echo "You must set the ARCH variable" >&2
  exit 1
fi

[[ -z $GAMESTATION_VERSION_LABEL ]] && GAMESTATION_VERSION_LABEL=gamestation-dev

docker build -t "gamestation-dev" \
	--build-arg USERNAME="`whoami`" \
	--build-arg USER_ID="`id -u`" \
	--build-arg GROUP_ID="`id -g`" \
	--build-arg LOCAL_PWD="$PWD" \
	-f scripts/Dockerfile.local .

#~ docker run --rm -d \
	#~ -v $(pwd):/work \
	#~ -v $(pwd):$(pwd) \
	#~ -v "${PWD}/dl":/share/dl \
	#~ -e "ARCH=${ARCH}" \
	#~ -e "GAMESTATION_VERSION_LABEL=${GAMESTATION_VERSION}" \
	#~ "gamestation-dev"


#~ docker run --rm \
	#~ -w="$(pwd)" \
	#~ -v $(pwd):$(pwd) \
	#~ -v "${PWD}/dl":/share/dl \
	#~ -e "ARCH=${ARCH}" \
	#~ -e "GAMESTATION_VERSION_LABEL=${GAMESTATION_VERSION}" \
	#~ --user="`id -u`:`id -g`" \
	#~ "gamestation-dev"

NPM_PREFIX_OUTPUT_PATH="`pwd`/output/build/.npm"
mkdir -p "$NPM_PREFIX_OUTPUT_PATH"
docker run --rm \
	-w="$(pwd)" \
	-v $(pwd):$(pwd) \
	-v "$NPM_PREFIX_OUTPUT_PATH":"/.npm" \
	-v "${PWD}/dl":/share/dl \
	-e "ARCH=${ARCH}" \
	-e "PACKAGE=${PACKAGE}" \
	-e "GAMESTATION_VERSION_LABEL=${GAMESTATION_VERSION}" \
	--user="`id -u`:`id -g`" \
	"gamestation-dev"

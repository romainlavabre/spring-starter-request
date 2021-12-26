#!/bin/bash

BASE_DIR="$1"
PACKAGE_PARSER=${BASE_DIR/"$2/src/main/java/com/"/""}
PACKAGES=""

IFS='/' read -ra ARRAY <<<"$PACKAGE_PARSER"
I=0

for PART in "${ARRAY[@]}"; do
    if [ "$I" == "0" ]; then
        PACKAGES="$PART"
    fi

    if [ "$I" == "1" ]; then
        PACKAGES="${PACKAGES}.${PART}"
    fi

    I=$((I + 1))
done

CLASSES=(
    "$1/MockRequest.java"
    "$1/Request.java"
    "$1/RequestImpl.java"
    "$1/UploadedFile.java"
    "$1/UploadedFileImpl.java"
)

for CLASS in "${CLASSES[@]}"; do
    sed -i "s|replace.replace|$PACKAGES|" "$CLASS"
done

#!/bin/bash

# Token 
TOKEN=$INPUT_GITHUB_TOKEN

# Token 
URL_PARAMS=$INPUT_URL_PARAMS

# File Param
FILE_PARAM=$INPUT_FILE_PARAM
CURL_FILE_PARAM=""
if ! [[ -z ${$INPUT_FILE_PARAM} ]]; then
  CURL_FILE_PARAM="-d $INPUT_FILE_PARAM"
fi

# URL that will receive the file
TO_URL=$INPUT_TO_URL

# Tag version
TAG="${GITHUB_REF:10}"
if ! [[ -z ${$INPUT_TAG_VERSION} ]]; then
  TAG=$INPUT_TAG_VERSION
fi

# Repository, including author/repository
REPO=$GITHUB_REPOSITORY
if ! [[ -z ${INPUT_REPOSITORY} ]]; then
  REPO=INPUT_REPOSITORY
fi

echo $URL_PARAMS;

# Downloads the tag
$(eval "curl -vLJO -H 'Authorization: token $TOKEN' 'https://github.com/$REPO/archive/refs/tags/$TAG.zip'")

# Uploads the file
RESPONSE=$(eval "curl $CURL_FILE_PARAM -F 'custom_param=1234' -F '$FILE_PARAM=@$TAG.zip' '$TO_URL'")

# Response
#echo $RESPONSE;
echo "::set-output name=response::$RESPONSE"
#!/bin/bash

# Token 
TOKEN=$INPUT_GITHUB_TOKEN

# URL Params (https://www.reddit.com/r/bash/comments/97mvvh/iterating_through_json_kv_pairs/)
URL_PARAMS=$INPUT_URL_PARAMS
CURL_URL_PARAMS=""
if ! [[ -z "$INPUT_URL_PARAMS" ]]; then
	shopt -s lastpipe
	jq -r 'to_entries | map(.key + "|" + (.value | tostring)) | .[]' <<<"$URL_PARAMS" | \
  	while IFS='|' read key value; do  		
    	CURL_URL_PARAMS="$CURL_URL_PARAMS -F '$key=$value'"    	
  	done	
fi

# File Param when sending to url
FILE_PARAM=$INPUT_FILE_PARAM

# URL that will receive the file
TO_URL=$INPUT_TO_URL

# Tag version
TAG="${GITHUB_REF:10}"
if ! [[ -z $($INPUT_TAG_VERSION) ]]; then
  TAG=$INPUT_TAG_VERSION
fi

# Repository, including author/repository
REPO=$GITHUB_REPOSITORY
if ! [[ -z ${INPUT_REPOSITORY} ]]; then
  REPO=$INPUT_REPOSITORY
fi

# Extension
EXT=$INPUT_FILENAME_EXT

# Filename
FILENAME="${REPO##*/}-$TAG"
if ! [[ -z ${INPUT_FILENAME} ]]; then
  FILENAME=$INPUT_FILENAME
fi

# Filename with extension
FILENAME_FULL="$FILENAME.$EXT"

# Downloads the tag
GITHUB_RESPONSE=$(eval "curl -vLJ -H 'Authorization: token $TOKEN' 'https://api.github.com/repos/$REPO/zipball/$TAG' --output '$FILENAME_FULL'")
# echo $GITHUB_RESPONSE;

# Renames zip archive folder
unzip $FILENAME_FULL
rm $FILENAME_FULL
cd */
mv ../{"${PWD##*/}",${FILENAME}}
cd ..
zip -r $FILENAME_FULL .

# Uploads the file
RESPONSE=$(eval "curl $CURL_URL_PARAMS -F '$FILE_PARAM=@$FILENAME_FULL' '$TO_URL'")

echo $RESPONSE

# Response
TEST="abc"
#echo "::set-output name=response::$RESPONSE"
echo "::set-output name=response::$TEST"
#!/bin/bash

# Token 
TOKEN=$INPUT_GITHUB_TOKEN

#echo '=====';
# URL Params 
URL_PARAMS=$INPUT_URL_PARAMS
echo $URL_PARAMS
CURL_URL_PARAMS=""
if ! [[ -z "$INPUT_URL_PARAMS" ]]; then
	jq -r 'to_entries | map(.key + "|" + (.value | tostring)) | .[]' <<<"$URL_PARAMS" | \
  	while IFS='|' read key value; do
    	CURL_URL_PARAMS += " -F '$key=$value'"
  	done
	#jq -c '.[]' <<< "$URL_PARAMS" | while read i; do
    #	echo $i;
	#done
	#for k in $(jq '.children.values | keys | .[]' <<< "$URL_PARAMS"); do		
	#    #CURL_URL_PARAMS+= " -F ''"
	#done | column -t -s$'\t'
fi

echo $CURL_URL_PARAMS

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

# Filename
FILENAME="${REPO##*/}-$TAG.zip"
if ! [[ -z ${INPUT_FILENAME} ]]; then
  FILENAME=$INPUT_FILENAME
fi

# Downloads the tag
#GITHUB_RESPONSE=$(eval "curl -vLJ -H 'Authorization: token $TOKEN' 'https://api.github.com/repos/$REPO/zipball/$TAG' --output '$FILENAME'")
echo $GITHUB_RESPONSE;

# Uploads the file
#RESPONSE=$(eval "curl -F 'custom_param=1234' -F '$FILE_PARAM=@$FILENAME' '$TO_URL'")

# Response
echo "::set-output name=response::$RESPONSE"
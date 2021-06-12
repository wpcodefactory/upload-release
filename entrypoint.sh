#!/bin/sh -l

OWNER="wpcodefactory"
REPO="test-plugin"
TOKEN=$INPUT_GITHUB_TOKEN
#TAG=$INPUT_TAG_VERSION
FILE_PARAM=$INPUT_FILE_PARAM


TAG="${GITHUB_REF:10}"
if ! [[ -z ${INPUT_REPO} ]]; then
  TAG=$INPUT_TAG_VERSION
fi


#JSON_URL=https://api.github.com/repos/$OWNER/$REPO/releases/latest
#echo $JSON_URL
#/usr/bin/curl -u $TOKEN:x-oauth-basic $JSON_URL > latest.json
#cat latest.json
#echo '!!'
#ID=`cat latest.json | jq '.assets[0].id' | tr -d '"'`
#echo "ID --> " $ID
#URL=https://$TOKEN@api.github.com/repos/$OWNER/$REPO/releases/assets/$ID
#/usr/bin/curl -L -H "Accept:application/octet-stream" $URL | tar -xzv --strip-components=1
#rm -rf latest.json

echo "TAG" + $TAG
echo "FILE_PARAM" + $FILE_PARAM
echo "GITHUB_REF" + $GITHUB_REF


TESTE=$(eval "curl -vLJO -H 'Authorization: token $TOKEN' 'https://github.com/$OWNER/$REPO/archive/refs/tags/$TAG.zip'")
ls

UPLOAD=$(eval "curl -F '$FILE_PARAM=1234' -F '$FILE_PARAM=@$TAG.zip' 'http://ca4198430e4d.ngrok.io/wpdev/'")
echo $UPLOAD;




#CURL="curl -H 'Authorization: token $TOKEN' \
      #https://api.github.com/repos/$OWNER/$REPO/releases"; \
#ASSET_ID=$(eval "$CURL/tags/$TAG" | jq .id); \


#echo $LATEST;
#echo $TESTE;



#TESTE=$(eval "curl -H 'Authorization: token $TOKEN' \
#     -H 'Accept:application/octet-stream' \
#     -i $DOWNLOAD_URL")






#DOWNLOAD_URL=$(eval "$CURL/tags/$TAG" | jq .zipball_url); \

#echo $DOWNLOAD_URL;

#TESTE=$(eval "curl -H 'Authorization: token $TOKEN' \
#     -H 'Accept:application/octet-stream' \
#     -i $DOWNLOAD_URL")

#echo $TESTE




#eval "$CURL/assets/$ASSET_ID -LJOH 'Accept: application/octet-stream' --output test.zip"


#curl -vLJO -H 'Authorization: token $INPUT_TOKEN' 'https://api.github.com/repos/$OWNER/$REPO/releases/assets/$ASSET_ID'
#ls
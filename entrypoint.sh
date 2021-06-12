#!/bin/sh -l

OWNER="wpcodefactory"
REPO="test-plugin"
#TOKEN=$INPUT_GITHUB_TOKEN
TOKEN=$GITHUB_TOKEN
TAG=1.0.0

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

echo $GITHUB_TOKEN
echo $GITHUB_REF
echo $GITHUB_REF#refs/*/


TESTE=$(eval "curl -vLJO -H 'Authorization: token $TOKEN' 'https://github.com/$OWNER/$REPO/archive/refs/tags/$TAG.zip'")
ls

UPLOAD=$(eval "curl -F 'userid=1234' -F 'wpfactory_release_file=@$TAG.zip' 'http://ca4198430e4d.ngrok.io/wpdev/'")
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
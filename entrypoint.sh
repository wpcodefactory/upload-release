#!/bin/sh -l

#OWNER="wpcodefactory"
#REPO="test-plugin"
#TOKEN=$INPUT_TOKEN

#JSON_URL=https://api.github.com/repos/$OWNER/$REPO/releases/latest
#echo $JSON_URL
#/usr/bin/curl -u $TOKEN:x-oauth-basic $JSON_URL > latest.json
#ID=`cat latest.json | jq '.assets[0].id' | tr -d '"'`
#echo "ID --> " $ID
#URL=https://$TOKEN@api.github.com/repos/$OWNER/$REPO/releases/assets/$ID
#/usr/bin/curl -L -H "Accept:application/octet-stream" $URL | tar -xzv --strip-components=1
#rm -rf latest.json


# Script to download asset file from tag release using GitHub API v3.
# See: http://stackoverflow.com/a/35688093/55075    

GITHUB_API_TOKEN=$INPUT_TOKEN
CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

# Check dependencies.
set -e
type curl grep sed tr >&2
xargs=$(which gxargs || which xargs)

# Validate settings.
[ -f ~/.secrets ] && source ~/.secrets
[ "$GITHUB_API_TOKEN" ] || { echo "Error: Please define GITHUB_API_TOKEN variable." >&2; exit 1; }
[ $# -ne 4 ] && { echo "Usage: $0 [owner] [repo] [tag] [name]"; exit 1; }
[ "$TRACE" ] && set -x
read owner repo tag name <<<$@

# Define variables.
GH_API="https://api.github.com"
GH_REPO="$GH_API/repos/wpcodefactory/test-plugin"
GH_TAGS="$GH_REPO/releases/tags/1.0.0"
AUTH="Authorization: token $GITHUB_API_TOKEN"
WGET_ARGS="--content-disposition --auth-no-challenge --no-cookie"
CURL_ARGS="-LJO#"

# Validate token.
curl -o /dev/null -sH "$AUTH" $GH_REPO || { echo "Error: Invalid repo, token or network issue!";  exit 1; }

# Read asset tags.
response=$(curl -sH "$AUTH" $GH_TAGS)
# Get ID of the asset based on given name.
eval $(echo "$response" | grep -C3 "name.:.\+$name" | grep -w id | tr : = | tr -cd '[[:alnum:]]=')
#id=$(echo "$response" | jq --arg name "$name" '.assets[] | select(.name == $name).id') # If jq is installed, this can be used instead. 
[ "$id" ] || { echo "Error: Failed to get asset id, response: $response" | awk 'length($0)<100' >&2; exit 1; }
GH_ASSET="$GH_REPO/releases/assets/$id"

# Download asset file.
echo "Downloading asset..." >&2
curl $CURL_ARGS -H "Authorization: token $GITHUB_API_TOKEN" -H 'Accept: application/octet-stream' "$GH_ASSET"
echo "$0 done." >&2
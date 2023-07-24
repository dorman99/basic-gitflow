version=$1


if [[ ! $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Invalid version number: $version"
  exit 1
fi

echo "Generate release tag for: $1...";

git checkout -b release/$version
npm version $version
git tag $version
git-chglog -o CHANGELOG.md
git add .
git commit -m "release: $version"
git push origin release/$version
git push origin --tag

animate_loading() {
  local i=0
  local chars="/-\|"

  while true; do
    i=$(( (i+1) % 4 ))
    printf "\r%s" "${chars:$i:1}"
    sleep 0.1
  done
}


animate_loading &

sleep 5

kill $!
echo THIS IS A DO NOTHING SCRIPT... FOR NOW
echo

# Update the index file version number
echo Edit the neat.html file to point to the new version download link

# Create a release tag and push it to Github
echo git checkout master
echo git tag -a v0.0.4 -m "Version 0.0.4 release of Neat."
echo git push --tags

# Update the gh-pages (demo) branch and push it back to Github, making it live
echo git checkout gh-pages
echo git merge master --no-edit
echo cp neat.html index.html
echo git commit -m "Updating the gh-pages (demo) branch for v0.0.2 release"
echo git push

echo Draft a release with the new tag on Github

# Create a release tag and push it to Github
git checkout master
git tag -a v0.0.2 -m "v0.0.2" -m "Version 0.0.2 release of Neat."
git push --tags

# Update the gh-pages (demo) branch and push it back to Github, making it live
git checkout gh-pages
git merge master --no-edit
cp neat.html index.html
git commit -m "Updating the gh-pages (demo) branch for v0.0.2 release"
git push
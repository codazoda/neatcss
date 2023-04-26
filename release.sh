# This is too complex. I need to simplify.
#
# One way I could do that is to move the index.html file into the main branch
# and not have two. The down side to that is that if someone downloads the
# whole project, they get that index.html file with my tracker. I don't want
# that.
#
# The way it's setup right now, that index.html file is only in the much
# more obscure gh_pages branch, so people don't even see it. That's why it's
# there.
#
# I did remove instructions for downloading the release zip files, however.
# Maybe that's enough to prevent people from grabbing the counter.
#
# Maybe I should create an action that runs on this? The downside to this
# approach is that it creates vendor lock-in, something that I've been able
# to prevent across my repos right now.
#
# My deploy process could be to cat neat.html plus the tracker to the index.html
# file and send that up to the gh_pages branch. I could do that easy enough
# in a simple bash script, I think.

echo THIS IS A DO NOTHING SCRIPT... FOR NOW
echo

# Update the index file version number
echo Edit the neat.html file to point to the new version download link
echo git add .
echo git commit -m 'Update version file for next version'

# Create a release tag and push it to GitHub
echo git checkout master
echo git tag -a v0.0.x -m "Version 0.0.x release"
echo git push --tags

# Update the gh-pages (demo) branch and push it back to GitHub, making it live
echo git checkout gh-pages
echo git merge master --no-edit (careful)
echo cp neat.html index.html
echo "<script src=\"https://counter.joeldare.com/counter.js\" async></script>" >> index.html
echo git commit -m "Updating the gh-pages (demo) branch for v0.0.x release"
echo git push

echo Convert the new tag to a release on GitHub

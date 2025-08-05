# Describe this script
echo This script releases by tagging a new version and pushing master up to origin.
echo

# Grab the current version number
CURRENT=`tail -1 version.txt`
NEXT=`tail -1 version.txt | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{$NF=sprintf("%0*d", length($NF), ($NF+1)); print}'`
FEAT=`git rev-parse --abbrev-ref HEAD`

# Show additional detail and wait for confirmation
echo Current version: $CURRENT
echo 
echo To change the major or minor version number:
echo "    echo x.x.0 >> version.txt"
echo
echo Releasing $FEAT branch as v$NEXT
echo
read -p "Press Enter to continue or Ctrl-C to stop"

# Verify we're on master
if [ "$FEAT" == "master" ]; then

    # Grab the current version number
    CURRENT=`tail -1 version.txt`
    NEXT=`tail -1 version.txt | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{$NF=sprintf("%0*d", length($NF), ($NF+1)); print}'`
    FEAT=`git rev-parse --abbrev-ref HEAD`

    # Show additional detail and wait for confirmation
    echo Current version: $CURRENT
    echo 
    echo To change the major or minor version number:
    echo "    echo x.x.0 >> version.txt"
    echo
    echo Releasing $FEAT branch as v$NEXT
    echo
    read -p "Press Enter to continue or Ctrl-C to stop"

    # Append an incremented version number to the version.txt file
    echo $NEXT >> version.txt

    # Append commit messages to the CHANGELOG file
    echo $NEXT >> CHANGELOG.txt
    git log v$CURRENT..HEAD --pretty="  - %s" --no-merges >> CHANGELOG.txt
    echo >> CHANGELOG.txt

    # Copy the css files to the docs file (for GH Pages)
    cp neat.css ./docs/
    cp custom.css ./docs/
    cp neat.html ./docs
    cp neat.html ./docs/index.html
    echo "<script src=\"https://counter.joeldare.com/counter.js\" async></script>" >> ./docs/index.html

    # Commit the changes above
    git add version.txt
    git add CHANGELOG.txt
    git add ./docs/neat.css
    git add ./docs/custom.css
    git add ./docs/neat.html
    git add ./docs/index.html
    if ! git commit -m "docs: update version number and docs css"; then
        echo ERROR: Unable to commit version and css files.
        exit 1
    fi

    # Create a release tag and push it to GitHub
    if ! git tag -a v$NEXT -m "release: v$NEXT"; then
        echo ERROR: Failed to tag the new version.
        exit 1
    fi
    if ! git push; then
        echo ERROR: Failed to push all committed changes.
        exit 1
    fi
    if ! git push --tags; then
        echo ERROR: Failed to push the new tag.
        exit 1
    fi

    # Exit with a successful code
    exit 0

fi

# Exit with an error code
echo "You should be on the master branch."
exit 1

# Describe this script
echo This script releases a feature branch by merging the current branch into
echo master, tagging a new version, and pushing master up to origin.
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
echo Releasing $FEAT branch as $NEXT
echo
read -p "Press Enter to continue or Ctrl-C to stop"

# Verify we aren't on master
if [ "$FEAT" != "master" ]; then

    # Append an incremented version number to the version.txt file
    echo $NEXT >> version.txt

    # Copy the css files to the docs file (for GH Pages)
    cp neat.css ./docs/
    cp custom.css ./docs/

    # Create a release tag and push it to GitHub
    git checkout master
    git merge $FEAT
    git tag -a $NEXT -m "Version $NEXT release"
    git push --tags

    # Exit with a successful code
    exit 0

fi

# Exit with an error code
echo "You should be on a feature branch."
exit 1

#!/usr/bin/env bash
 
GIT_NEW_WORKDIR=~/bin/git-new-workdir
REPOS=clone
 
print_help() {
    echo Usage: $1 [bootstrap dir] [dest dir] [branch name]
}
 
die() {
    echo $1
    exit 1
}
 
BOOTSTRAP_DIR="$1"
DEST_DIR="$2"
BRANCH="$3"
 
if [ "$BOOTSTRAP_DIR" = "" ]; then
    echo bootstrap repo is missing.
    print_help $0
    exit 1
fi
 
if [ "$DEST_DIR" = "" ]; then
    echo destination directory is missing.
    print_help $0
    exit 1
fi
 
if [ "$BRANCH" = "" ]; then
    echo branch name is missing.
    print_help $0
    exit 1
fi
 
if [ -e "$DEST_DIR/$BRANCH" ]; then
    die "$DEST_DIR/$BRANCH already exists."
fi
 
# Clone bootstrap first.
$GIT_NEW_WORKDIR "$BOOTSTRAP_DIR" "$DEST_DIR/$BRANCH" "$BRANCH" || die "failed to clone bootstrap repo."
 
# First, check out the branches.
echo "creating directory $DEST_DIR/$BRANCH/$REPOS"
mkdir -p "$DEST_DIR/$BRANCH/$REPOS" || die "failed to create $DEST_DIR/$BRANCH/$REPOS"
for repo in `ls "$BOOTSTRAP_DIR/clone"`; do
    repo_path="$BOOTSTRAP_DIR/clone/$repo"
    if [ ! -d $repo_path ]; then
        # we only care about directories.
        continue
    fi
    echo ===== $repo =====
    $GIT_NEW_WORKDIR $repo_path "$DEST_DIR/$BRANCH/$REPOS/$repo" $BRANCH
done
 
# Set symbolic links to the root directory.
cd "$DEST_DIR/$BRANCH"
for repo in `ls $REPOS`; do
    repo_path=$REPOS/$repo
    if [ ! -d $repo_path ]; then
        # skip if not directory.
        continue
    fi
    ln -s -t . $repo_path/*
done

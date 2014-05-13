Say we have a git repo here:

/home/rber/projects/docker/yocto-autobuilder

and we want to make a directory which contains branches of this repo as directories

mkdir -p /home/rber/projects/docker/yocto-autobuilder-top

now clone the original repo locally in there:

cd /home/rber/projects/docker/yocto-autobuilder-top

git clone ssh://rber@localhost/home/rber/projects/docker/yocto-autobuilder yocto-autobuilder-test

cd yocto-autobuilder-test

cp -r ~/projects/meta-mainline-top/meta-mainline-test/bin .

# create a new branch
git branch phusion
git co phusion
git branch -a

# back to master
git co master
git branch -a

# create the folder, which matches the branch
cd /home/rber/projects/docker/yocto-autobuilder-top
 ./yocto-autobuilder-test/bin/create-branch-build.sh yocto-autobuilder-test . phusion

you should see:
 Switched to branch 'phusion'
 creating directory ./phusion/clone
 ls: cannot access yocto-autobuilder-test/clone: No such file or directory


# in order to be able to pull it over from yocto-test you also need to create a branch
# . with the same name in yocto-autobuilder

cd /home/rber/projects/docker/yocto-autobuilder/
git co master
git branch phusion
git branch -a

git co master
git branch -a

# now we need a way to pull branches and fixed over to yocto
cd /home/rber/projects/docker/yocto-autobuilder/scripts
cp ~/projects/docker/yocto/scripts/pull-from-yocto-top.sh .
mv pull-from-yocto-top.sh pull-from-yocto-autobuilder-top.sh

# and you need to cook pull-from-yocto-autobuilder-top.sh


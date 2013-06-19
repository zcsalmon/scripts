#! /bin/bash
brand=$1

echo "Creating app_shell for ${brand}..."

path=~/mpp

echo "Updating media/${brand} media/_defaultBrandSettings and media/templates/trunk"

svn up $path/media/$brand $path/media/_defaultBrandSettings $path/templates/trunk

echo "Copying app shell from app_shell_ios/trunk. Creating branch for ${brand}"

svn cp https://test.freerange360.com/svn/app_shell_ios/trunk https://test.freerange360.com/svn/app_shell_ios/branches/$brand -m "creating app shell for ${brand}"

echo "Checking out app_shell branch for : ${brand}"

svn co https://test.freerange360.com/svn/app_shell_ios/branches/$brand

echo "Running generate_app_shell.py script"

generate_app_shell.py $path/media/$brand $path/$brand $path/templates/trunk

echo "Finishing up. Running mvn package and generating strings."

cd $path/$brand
mvn package
open AppShell.xcworkspace/
generate_ios_strings.sh $brand
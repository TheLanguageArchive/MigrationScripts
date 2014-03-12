# This script exists only to migrate the svn branches correctly into git. 
# Secondarily this script will also migrate the tickets from track to github, hopefully with all the commit triggers/references intact.

git svn clone https://svn.mpi.nl/LAT --authors-file=users.txt --follow-parent --branches=documentation/manuals/kinoath --trunk=Kinnate/trunk --branches=Kinnate/branches
# multiple branches seems to fail so we have used tags and branches to pull in the various svn directoris as branches
#git svn clone https://svn.mpi.nl/LAT --authors-file=users.txt  --follow-parent --branches=IntegrationTests/trunk/Kinoathtestcases.txt --branches=documentation/manuals/kinoath --trunk=Kinnate/trunk --branches=Kinnate/branches
cd LAT/
git remote add origin https://github.com/PeterWithers/KinOathKinshipArchiver.git
#git push -u origin master
git push --all -u

python trac2github.py user@sample.com PeterWithers KinOathKinshipArchiver
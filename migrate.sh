# This script exists only to migrate the svn branches correctly into git. 
# Secondarily this script will also migrate the tickets from track to github, hopefully with all the commit triggers/references intact.

# https://github.com/nirvdrum/svn2git#readme
sudo apt-get install git-core git-svn ruby rubygems
sudo gem install svn2git

svn2git https://svn.mpi.nl/LAT --authors users.txt --notags --branches documentation/manuals/kinoath --branches Kinnate/branches --branches IntegrationTests/trunk/Kinoathtestcases.txt --trunk Kinnate/trunk

#git svn clone https://svn.mpi.nl/LAT --authors-file=users.txt --follow-parent --branches=documentation/manuals/kinoath --trunk=Kinnate/trunk --branches=Kinnate/branches
# multiple branches seems to fail so we have used tags and branches to pull in the various svn directoris as branches
#git svn clone https://svn.mpi.nl/LAT --authors-file=users.txt  --follow-parent --branches=IntegrationTests/trunk/Kinoathtestcases.txt --branches=documentation/manuals/kinoath --trunk=Kinnate/trunk --branches=Kinnate/branches
cd LAT/
git remote add origin https://github.com/PeterWithers/KinOathKinshipArchiver.git
#git push -u origin master
git push --all -u

python trac2github.py user@sample.com PeterWithers KinOathKinshipArchiver
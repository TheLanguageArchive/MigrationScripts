# This script exists only to migrate the svn branches correctly into git. 
# Secondarily this script will also migrate the tickets from track to github, hopefully with all the commit triggers/references intact.

# Please note that this process is tested and used on a debian machine because it has been observed that git svn and svn2git do not produce correct results if they are run on MacOs. 

# https://github.com/nirvdrum/svn2git#readme
sudo apt-get install git-core git-svn ruby rubygems
sudo gem install svn2git

# it is too messy to have the documentation and test plan as branches in one monolithic repository, so we now have the project separated into five parts:
# TestingProcedure
# UserManual
# MigrationScripts
# DesktopInstaller
# KinOathKinshipArchiver


# UserManual
# https://github.com/KinshipSoftware/UserManual.git
mkdir UserManual;
cd UserManual;
svn2git https://svn.mpi.nl/LAT --authors ../users.txt --notags --nobranches --trunk documentation/manuals/kinoath;
git remote add origin https://github.com/KinshipSoftware/UserManual.git;
git push --all -u;
cd ..;

# DesktopInstaller
# https://github.com/KinshipSoftware/DesktopInstaller.git
mkdir DesktopInstaller;
cd DesktopInstaller;
svn2git https://svn.mpi.nl/LAT --authors ../users.txt --tags DesktopInstaller/tags --branches DesktopInstaller/branches --trunk DesktopInstaller/trunk;
git remote add origin https://github.com/KinshipSoftware/DesktopInstaller.git;
git push --all -u;
cd ..;

# KinOathKinshipArchiver
# https://github.com/KinshipSoftware/KinOathKinshipArchiver.git
mkdir KinOathKinshipArchiver;
cd KinOathKinshipArchiver;
svn2git https://svn.mpi.nl/LAT --authors ../users.txt --tags Kinnate/tags --branches Kinnate/branches --trunk Kinnate/trunk;
git remote add origin https://github.com/KinshipSoftware/KinOathKinshipArchiver.git;
git push --all -u;
cd ..;

#https://trac.mpi.nl/browser/latsvn/IntegrationTests/trunk/Kinoathtestcases.txt
# TestingProcedure
# https://github.com/KinshipSoftware/TestingProcedure.git
mkdir TestingProcedure;
cd TestingProcedure;
#svn2git https://svn.mpi.nl/LAT --authors ../users.txt --exclude "^[^K].*" --notags --nobranches --trunk IntegrationTests/trunk/;
#svn2git https://svn.mpi.nl/LAT --authors ../users.txt --exclude "^(?!IntegrationTests/trunk/Kinoathtestcases.txt)" --notags --nobranches --trunk IntegrationTests/trunk/;
svn2git https://svn.mpi.nl/LAT --authors ../users.txt --exclude "^(?!.*(?:Kinoath))" --notags --nobranches --trunk IntegrationTests/trunk/;
git remote add origin https://github.com/KinshipSoftware/TestingProcedure.git;
git push --all -u;
cd ..;



# it is too messy to have the documentation and test plan as branches in one monolithic repository
#svn2git https://svn.mpi.nl/LAT --authors ../users.txt --notags --branches documentation/manuals/kinoath --branches Kinnate/branches --trunk Kinnate/trunk
#svn2git https://svn.mpi.nl/LAT --authors users.txt --notags --branches documentation/manuals/kinoath --branches Kinnate/branches --branches IntegrationTests/trunk/Kinoathtestcases.txt --trunk Kinnate/trunk


# git svn clone has not proved to produce good branches 
#git svn clone https://svn.mpi.nl/LAT --authors-file=../users.txt --follow-parent --trunk=Kinnate/trunk --branches=Kinnate/branches --branches=documentation/manuals/kinoath
#git svn clone https://svn.mpi.nl/LAT --authors-file=users.txt --follow-parent --branches=documentation/manuals/kinoath --trunk=Kinnate/trunk --branches=Kinnate/branches
# multiple branches seems to fail so we have used tags and branches to pull in the various svn directoris as branches
#git svn clone https://svn.mpi.nl/LAT --authors-file=users.txt  --follow-parent --branches=IntegrationTests/trunk/Kinoathtestcases.txt --branches=documentation/manuals/kinoath --trunk=Kinnate/trunk --branches=Kinnate/branches
cd LAT/

git branch
git branch -a
git tag -l

#git remote add origin https://github.com/PeterWithers/KinOathKinshipArchiver.git
#git push -u origin master
#git push --all -u

#python trac2github.py user@sample.com KinshpSoftware KinOathKinshipArchiver


# it was hoped that --follow-parent might have included the history when a file has been moved or copied, however this seems not to work based on the following test
# DesktopInstaller2
mkdir DesktopInstaller2;
cd DesktopInstaller2;
git svn clone https://svn.mpi.nl/LAT --authors-file=users.txt --follow-parent --trunk=DesktopInstaller/trunk;
git push --all -u;
git log --reverse;
cd ..;
# !bin/bash
# This is a script used to get your github account working
#git clone https://github.com/Aolajresounds/package-management.git
#cd package-management
git init
git branch -M main
git add .
git commit -m "part_3 Prometheus Setup "
git remote add origin https://github.com/Aolajre/atVenu.git
git push -uf origin main
#Output from config 
git status
git remote -v

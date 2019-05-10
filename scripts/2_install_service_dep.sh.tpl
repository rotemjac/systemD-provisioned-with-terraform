#!/usr/bin/env bash

###-------------- Server -----------------###
cd ${home_dir}/${git_repo_name}/server
npm install

## If you want also to run the app (not as a systemD service)
#sleep 10
#/usr/bin/node ${home_dir}/${git_repo_name}/server/server.js &



###-------------- Client -----------------###
cd ${home_dir}/${git_repo_name}/public
npm install
sudo npm install -g @angular/cli@latest --unsafe-perm

#Example for special case scripts
npm install @fortawesome/fontawesome-free

#ng build --prod --aot
ng build
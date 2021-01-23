#!/bin/bash

token=$1
repo=$2 #owner and repository: ie: user/repo
update_command=$3
update_path=$4
username=$GITHUB_ACTOR #${5:-$GITHUB_ACTOR}

echo "**********************************"
echo $GITHUB_ACTOR
echo $GITHUB_REF
echo ${GITHUB_REF##}
echo $GITHUB_REPOSITORY
echo $GITHUB_API_URL
echo "**********************************"

branch_name="automated-dependencies-update"
email="noreply@github.com"

if [ -z "$token" ]; then
    echo "token is not defined"
    exit 1
fi

if [ -n "$update_path" ]; then
    # if path is set, use that. otherwise default to current working directory
    echo "Change directory to $update_path"
    # TODO cd ${update_path}
fi

echo "Switched to $update_path"
cd './test/go'

# # assumes the repo is already cloned as a prerequisite for running the script

# # fetch first to be able to detect if branch already exists 
# git fetch

# # branch already exists, previous opened PR was not merged
# if [ -n "git branch --list $branch_name" ]
# then
#     echo "Branch name $branch_name already exists"

#     echo "Check out branch instead" 
#     # check out existing branch
#     git checkout $branch_name
#     git pull

#     # reset with latest from main
#     git reset --hard origin/main
# else
#     git checkout -b $branch_name
# fi

# echo "Running update command $update_command"
# eval $update_command

# if [ -n "git diff" ]
# then
#     echo "Updates detected"

#     # configure git authorship
#     git config --global user.email $email
#     git config --global user.name $username

#     # format: https://[username]:[token]@github.com/[organization]/[repo].git
#     git remote add authenticated "https://$username:$token@github.com/$repo.git"

#     # commit the changes to Cargo.lock
#     git commit -a -m "Auto-update cargo crates"
    
#     # push the changes
#     git push authenticated $branch_name -f

#     echo "https://api.github.com/repos/$repo/pulls"

#     # create the PR
#     # if PR already exists, then update
#     response=$(curl --write-out "%{message}\n" -X POST -H "Content-Type: application/json" -H "Authorization: token $token" \
#          --data '{"title":"Autoupdate dependencies","head": "'"$branch_name"'","base":"main", "body":"Auto-generated pull request. \nThis pull request is generated by GitHub action based on the provided update commands."}' \
#          "https://api.github.com/repos/$repo/pulls")
    
#     echo $response   
    
#     if [[ "$response" == *"already exist"* ]]; then
#         echo "Pull request already opened. Updates were pushed to the existing PR instead"
#         exit 0
#     fi
# else
#     echo "No dependencies updates were detected"
#     exit 0
# fi

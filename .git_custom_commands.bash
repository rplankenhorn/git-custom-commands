#!/bin/bash

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

eval "$(hub alias -s)"

if [ -f ~/.hub.bash_completion.sh ]; then
	. ~/.hub.bash_completion.sh
fi

gp () {
	BRANCH=`echo $git_branch | tr -d '()'`
	git push origin $BRANCH
}

cb () {
	if [ $# -eq 2 ]; then
		BRANCH=$1
		UPSTREAM=$2
		echo "$BRANCH/$UPSTREAM"
		git checkout -b $BRANCH/$UPSTREAM upstream/$UPSTREAM
	else
		echo "usage: cb [rally number] [upstream branch]"
		return 0;
	fi
}

cpr () {
	gp
	read -p "Upstream Branch: " UPSTREAM_BRANCH
	read -p "Rally Number: " RALLY
	read -p "Title: " TITLE
	URL=`git pull-request -m "${UPSTREAM_BRANCH}: ${RALLY}: ${TITLE}" -b ${UPSTREAM_BRANCH}`
	open $URL
}

gitclean () {
	git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
	git remote prune origin
}

gr () {
	git reset --soft HEAD~1
}

gt () {
	git commit -am "TEMP COMMIT"
}

grb () {
	git rebase upstream/master
}

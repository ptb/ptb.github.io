#!/bin/sh

DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
PLIST="${DIR}/.me.ptb2.autogit"

if [ ! -d "${DIR}/.git/" ]; then
  git init
fi

if [ -d "${DIR}/.git/hooks/" ] && [ ! -e "${DIR}/.git/hooks/prepare-commit-msg" ]; then
  /bin/sh -c "cd '${DIR}/.git/hooks/' && ln -fs ../../.prepare-commit-msg prepare-commit-msg && cd ../../";
fi

if [ -d "${DIR}/.git/hooks/" ] && [ ! -e "${DIR}/.git/hooks/post-commit" ]; then
  /bin/sh -c "cd '${DIR}/.git/hooks/' && ln -fs ../../.post-commit post-commit && cd ../../";
fi

find '.' -type d -name '.git' -print0 | sort -rz | while IFS= read -r -d '' gitdir1; do
  DIR1="$(cd "$(dirname "$gitdir1")" && pwd -P)"
  find "$DIR1" -type d -name '.git' -print0 | sort -rz | while IFS= read -r -d '' gitdir2; do
    DIR2="$(cd "$(dirname "$gitdir2")" && pwd -P)"
    find "$DIR2" -type d -empty -exec touch {}/.keep \;
    git --git-dir="$DIR1/.git" --work-tree="$DIR1/" add --all "$DIR2/"
  done
  find "$DIR1" -type d -empty -exec touch {}/.keep \;
  git --git-dir="$DIR1/.git" --work-tree="$DIR1/" add --all "$DIR1/"
  git --git-dir="$DIR1/.git" --work-tree="$DIR1" commit --message='' --allow-empty-message
done

if [ -f "${PLIST}.plist" ]; then
  /bin/echo -n 'Enter an id for this project/directory: '
  read PROJ
  launchctl unload -w "${HOME}/Library/LaunchAgents/me.ptb2.autogit.${PROJ}.plist" 2> /dev/null

  git mv "${PLIST}.plist" "${PLIST}.${PROJ}.plist"
  PLIST="${PLIST}.${PROJ}"
  git add "${PLIST}.plist"
  git commit --message='' --allow-empty-message

  sed -e "s/autogit/autogit.${PROJ}/" -e "s@path-to-source@${DIR}@" "${PLIST}.plist" > "${PLIST}.plist~" && mv "${PLIST}.plist~" "${PLIST}.plist"
  git add "${PLIST}.plist"
  git commit --message='' --allow-empty-message

  if [ ! -f "${HOME}/Library/LaunchAgents/me.ptb2.autogit.${PROJ}.plist" ]; then
    mkdir -p "${HOME}/Library/LaunchAgents/"
    cp -p "${PLIST}.plist" "${HOME}/Library/LaunchAgents/me.ptb2.autogit.${PROJ}.plist"
    launchctl load -w "${HOME}/Library/LaunchAgents/me.ptb2.autogit.${PROJ}.plist"
  fi
fi

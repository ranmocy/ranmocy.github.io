---
title: Howto Modify Author Name in Git History
created_at: 2013-05-05T22:35:17+08:00
updated_at: 2013-05-05T22:35:17+08:00
category: Tech
---

    git filter-branch --commit-filter '
    if [ "$GIT_COMMITTER_NAME" = "riku" ]; then export GIT_COMMITTER_NAME="Riku"; fi;
    if [ "$GIT_COMMITTER_NAME" = "ranmocy" ]; then export GIT_COMMITTER_NAME="Ranmocy Sheng"; fi;
    if [ "$GIT_COMMITTER_NAME" = "Ranmocy" ]; then export GIT_COMMITTER_NAME="Ranmocy Sheng"; fi;
    if [ "$GIT_COMMITTER_NAME" = "Wanzhang Sheng" ]; then export GIT_COMMITTER_NAME="Ranmocy Sheng"; fi;
    if [ "$GIT_COMMITTER_NAME" = "pake007" ]; then export GIT_COMMITTER_NAME="Jimmy Huang"; fi;
    if [ "$GIT_COMMITTER_NAME" = "jimmy" ]; then export GIT_COMMITTER_NAME="Jimmy Huang"; fi;
    if [ "$GIT_COMMITTER_NAME" = "ghosTM55" ]; then export GIT_COMMITTER_NAME="Thomas Yao"; fi;
    git commit-tree "$@"'

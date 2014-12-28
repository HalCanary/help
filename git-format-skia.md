# git-format-skia #

## use ##

To reformat in-place all changes since last commit (run before commiting):

    git-format-skia -i HEAD

To just see the changes without making them in place:

    git-format-skia HEAD

To reformat and amend the last commit:

    git-format-skia -i HEAD~
	git commit --all --amend --reuse-message=HEAD

## installation ##

1.  Copy [src/git-format-skia](src/git-format-skia) into your path.

2.  Install clang-format (TODO: document this).

3.  Install clang-format-diff.py (TODO: document this).

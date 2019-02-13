function _git_stash_and_unstash
    if [ $status = 0 ]
        git stash; and git checkout master; and git pull; and git stash pop
    end
end
function dic
    getopts $argv | while read -l key value
        switch $key
            case _
                command echo $value >> ~/projects/libs/utility/dictionary/bapm.dic      
            case \*
                echo unknown flag $key
        end
    end

    command sort -u ~/projects/libs/utility/dictionary/bapm.dic > ~/projects/libs/utility/dictionary/_bapm.dic
    command mv ~/projects/libs/utility/dictionary/_bapm.dic  ~/projects/libs/utility/dictionary/bapm.dic

    command git -C ~/projects/libs/utility/dictionary stage .
    command git -C ~/projects/libs/utility/dictionary commit -m 'Add word(s)'
    command git -C ~/projects/libs/utility/dictionary push --no-verify
end
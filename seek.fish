function seek
    set include ''

    getopts $argv | while read -l key value
        switch $key
            case _
                set search $value
            case e ext
                set include --include \*.$value
            case \*
                echo unknown flag $key

                # Handle unknown flags here
        end
    end

    grep -RI $include $search .
end

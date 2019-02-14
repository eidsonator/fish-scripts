function update
    set files .
    set message 'Update'

    getopts $argv | while read -l key value
        switch $key                
            case m message
                set message $value
            case f file
                set files $files
            case \*
                echo unknown flag $key
                return 1
                # Handle unknown flags here
        end
    end

    git add $files
    git stage $files
    git commit -m "$message"
    git push

end
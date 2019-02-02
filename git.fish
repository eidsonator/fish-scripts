function git

    if count $argv > /dev/null
        if [ $argv[1] = 'version' ]
            git_version $argv         
        else 
            command git $argv
            return $status
        end    
    else
        command git
        return $status 
    end

end

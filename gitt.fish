function gitt

    set dry false
    set build 
    set type
    set force false
    getopts $argv | while read -l key value
        switch $key
            case _
                switch $value
                    case major minor patch
                        set type $value
                        # Handle non-flags here (e.g. `$ foo bam`)
                    case alpha beta
                        # Handle `whatever` here
                        set build $value
                end
            case d dry
                set dry true
            case f force
                echo force
                set force true
            case v version
                _gitt_print_version
                return 0
            case \*
                echo unknown flag $key

                # Handle unknown flags here
        end
    end

    set v (git describe --abbrev=0 --tags)
    # strip any thing from the hyphen after to remove -alpha or -beta
    set v (string split "-" -- $v)[1]
    set vmajor (string split "." -- $v)[1]
    set vminor (string split "." -- $v)[2]
    set vpatch (string split "." -- $v)[3]

    if [ $type = 'patch' ]
        set vpatch (math $vpatch + 1)
    else if [ $type = 'minor' ]
        set vminor (math $vminor + 1)
        set vpatch 0
    else if [ $type = 'major' ]
        set vmajor (math $vmajor + 1)
        set vpatch 0
        set vminor 0        
    else
        echo "Help"
        echo "Accepts 'major', 'minor', or 'patch' as the first command line argument"
        
        return 0
    end

    if [ $build ]
        if [ $build = 'alpha' ]
            set build alpha
        else if [ $build = 'beta' ]
            set build beta
        else
            echo "The 'build' can only be blank, alpha, or beta"
            return 1
        end
        set tag $vmajor.$vminor.$vpatch-$build
    else 
        set tag $vmajor.$vminor.$vpatch
    end

    if $dry
        echo $tag
    else 
        if git_is_dirty            
            if $force
                echo 'Forcing new version'
            else
                echo 'git is dirty - must use --force'
                return 1
            end
        end
        git tag $tag
        git push origin master --tags
    end
end

function _gitt_print_version
    echo gitt verison increment 1.0.0
end

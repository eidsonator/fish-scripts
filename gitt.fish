function gitt

    if [ (count $argv) = 0 ]
        echo "You must pass either 'major', 'minor', or 'patch' as the first command line argument"
        return 1
    end

    set v (git describe --abbrev=0 --tags)
    set vmajor (string split "." -- $v)[1]
    set vminor (string split "." -- $v)[2]
    set vpatch (string split "." -- $v)[3]

    if [ $argv[1] = 'patch' ]
        set vpatch (math $vpatch + 1)
    else if [ $argv[1] = 'minor' ]
        set vminor (math $vminor + 1)
    else if [ $argv[1] = 'major' ]
        set vmajor (math $vmajor + 1)
    end

    if [ (count $argv) = 2 ]
        if [ $argv[2] = 'alpha' ]
            set build alpha
        else if [ $argv[2] = 'beta' ]
            set build beta
        else
            echo "The 'build' can only be blank, alpha, or beta"
            return 1
        end
        set tag $vmajor.$vminor.$vpatch-$build
    else 
        set tag $vmajor.$vminor.$vpatch
    end

    git tag $tag

    git push origin master --tags
end

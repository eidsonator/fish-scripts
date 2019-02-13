function new
    mkdir $argv[1]
    cd $argv[1]
    composer create-project symfony/skeleton current
    cd current
    composer require bapm/symfonic-bundle
    yarn add bapm-synthesis
end

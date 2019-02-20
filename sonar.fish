function sonar
    if test -e ./sonar-project.properties
        set v (git describe --abbrev=0 --tags)
        command sed "s/sonar.projectVersion=[0-9]*.[0-9]*.[0-9]*\(-alpha\)*\(-beta\)*\(-rc[0-9]*\)*/sonar.projectVersion=$v/g" sonar-project.properties > _sonar-project.properties
        command mv _sonar-project.properties sonar-project.properties

        command git stage sonar-project.properties
        command git commit -m "Update version"

        command git push --no-verify

        command /opt/sonar-scanner/bin/sonar-scanner $argv
    end 
end
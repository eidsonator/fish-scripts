function clean
    rimraf ./public/build
    rimraf ./public/bundles
    rimraf ./node_modules
    rimraf ./vendor
    rimraf ./var/*
    rimraf ../var/log*
    rimraf ../var/sessions
end

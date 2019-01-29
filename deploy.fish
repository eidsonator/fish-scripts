function deploy
	php bin/mage deploy $argv[1]
	if [ $status != 0 ]
		yarn dev
		rm VERSION
	end
end

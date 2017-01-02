#!/bin/bash

echo "Which version would you like to build?"
read version_variable

if [ ! -f download/prestashop_$version_variable.zip ]
	then
	echo "File not found! Download it & put it in your download folder."
	exit 1
else
	echo "Unzipping prestashop_$version_variable.zip"
	unzip download/prestashop_$version_variable.zip -d download/PrestaUnzipper && rm download/prestashop_$version_variable.zip
	unzip download/PrestaUnzipper/prestashop.zip -d download/PrestaShopContent

	echo "Copy of CLDR"
	cp core.zip download/PrestaShopContent/translations/cldr

	echo "Zipping prestashop_$version_variable.zip"
	cd download/PrestaShopContent && zip -rq9 ../../build/prestashop.zip . && cd ../../ && rm -Rf download/PrestaShopContent
	mv build/prestashop.zip download/PrestaUnzipper/
	cd download/PrestaUnzipper/ && zip -rq9 prestashop_$version_variable.zip .

	echo "Clean folders"
	cd ../../ && mv download/PrestaUnzipper/prestashop_$version_variable.zip build/ && rm -Rf download/PrestaUnzipper

	echo "Built! Your package is in your build folder"
fi

exit 0
#!/bin/sh
if [ "$1" == "-h" ] || [ "$1" == "--help" ]
	then
		printf "Auto yamie version 2.0\n-m [MODE]\t the mode you use when processing.\n-s [SOURCE]\t the source image you use.\n-e [TEMPLATE] \t the xcf template you use.\n-t [TARGET]\t the target photo you want to restore.\n-h --help \t print this help menu.\n"
		exit 0
	fi
mkdir -p generated
MODE="auto-yamie"
TEMPLATE="YaMie.xcf"
SOURCE="images"
TARGET=""
while getopts "m:e:s:t:" OPT; do
	case "$OPT" in
		m)
			MODE="$OPTARG";;
		e)
			TEMPLATE="$OPTARG";;
		s)
			SOURCE="$OPTARG";;
		t)
			TARGET="$OPTARG-";;
	esac
done
if [ -d $SOURCE ]
then
	for f in $SOURCE/*
	do 
		gimp $TEMPLATE -i -b "($MODE \"$f\" \"generated/$TARGET$(basename $f).webp\")" -b "(gimp-quit 0)"
	done
elif [ -f $SOURCE ]
then
	gimp $TEMPLATE -i -b "($MODE \"$SOURCE\" \"generated/$TARGET-$(basename $SOURCE).webp\")" -b "(gimp-quit 0)"
fi

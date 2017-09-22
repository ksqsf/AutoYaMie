#!/usr/bin/bash
mkdir -p generated
for f in images/*
do
  gimp YaMie.xcf -i -b "(auto-yamie \"$f\" \"generated/$(basename $f).webp\")" -b "(gimp-quit 0)"
done

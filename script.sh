#!/bin/bash
## on mac, need > for xxd output files
 
WORKDIR="/rootDir/ImageFiles/newtest"
DESTINATION="/rootDir/ImageFiles/test6"

cd $WORKDIR
FOLDERS=$(ls $WORKDIR)
for folder in $FOLDERS
 do 
    cd $folder
    for f in *.svs; do
    mkdir -p $DESTINATION/$folder
    FCHECK=`file $f | grep "TIFF"` 
      if [ "$FCHECK" ]; then
      cp $f $DESTINATION/$folder/$f 
      else     
      xxd -p $f $f.hex
      perl -pi'original-*' -we 'BEGIN{$/="49492a00"} chomp and s/.+/49492a00/s;' "$f.hex"
      xxd -r -p $f.hex $DESTINATION/$folder/$f
      rm *.hex
      fi 
    file $DESTINATION/$folder/$f
    done 
    cd ../
 done

#!/bin/bash

gcc -o in2alb in2alb.c
if [ ! -d classical ]; then
  mkdir classical
fi
for i in {7..14}
do
    ./in2alb scholl/BUXEY.IN2 classical/buxey_m${i}.alb ${i}
done
for i in {6..15}
do
    ./in2alb scholl/GUNTHER.IN2 classical/gunther_m${i}.alb ${i}
done
for i in {3..11}
do
    ./in2alb scholl/KILBRID.IN2 classical/kilbridge_m${i}.alb ${i}
done
for i in {8..12}
do
    ./in2alb scholl/LUTZ1.IN2 classical/lutz1_m${i}.alb ${i}
done
for i in {9..28}
do
    ./in2alb scholl/LUTZ2.IN2 classical/lutz2_m${i}.alb ${i}
done
for i in {7..14}
do
    ./in2alb scholl/SAWYER30.IN2 classical/sawyer_m${i}.alb ${i}
done
for i in {3..25}
do
    ./in2alb scholl/TONGE70.IN2 classical/tonge_m${i}.alb ${i}
done
for i in {3..22}
do
    ./in2alb scholl/ARC83.IN2 classical/arcus1_m${i}.alb ${i}
done
for i in {3..27}
do
    ./in2alb scholl/ARC111.IN2 classical/arcus2_m${i}.alb ${i}
done
for i in {3..10}
do
    ./in2alb scholl/HAHN.IN2 classical/hahn_m${i}.alb ${i}
done
for i in {3..29}
do
    ./in2alb scholl/WARNECKE.IN2 classical/warnecke_m${i}.alb ${i}
done
for i in {3..30}
do
    ./in2alb scholl/WEE-MAG.IN2 classical/wee-mag_m${i}.alb ${i}
done
for i in {3..23}
do
    ./in2alb scholl/LUTZ3.IN2 classical/lutz3_m${i}.alb ${i}
done
for i in {3..26}
do
    ./in2alb scholl/MUKHERJE.IN2 classical/mukherje_m${i}.alb ${i}
done
for i in {3..15}
do
    ./in2alb scholl/BARTHOLD.IN2 classical/barthold_m${i}.alb ${i}
done
for i in {27..51}
do
    ./in2alb scholl/BARTHOL2.IN2 classical/barthold2_m${i}.alb ${i}
done
for i in {25..52}
do
    ./in2alb scholl/SCHOLL.IN2 classical/scholl_m${i}.alb ${i}
done
#list number of files in folder classical/ (should be 302)
if [ "$(ls -1 classical | wc -l)" -eq 302 ]; then
  echo "Scholl SALBP-2 instances generated"
else
  echo "Issue in file generation"
fi

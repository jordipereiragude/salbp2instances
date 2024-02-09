#!/bin/bash

gcc -o alb otto.c
if [ ! -d new ]; then
  mkdir new
fi
if [ ! -d new/n20 ]; then
    mkdir new/n20
fi
if [ ! -d new/n50 ]; then
    mkdir new/n50
fi
if [ ! -d new/n100 ]; then
    mkdir new/n100
fi
if [ ! -d new/n150 ]; then
    mkdir new/n150
fi
if [ ! -d new/n200 ]; then
    mkdir new/n200
fi
if [ ! -d new/n250 ]; then
    mkdir new/n250
fi
if [ ! -d new/n500 ]; then
    mkdir new/n500
fi
if [ ! -d new/n1000 ]; then
    mkdir new/n1000
fi
for t in 20 50 100 1000
do
    if [ $t == 20 ]; then
        dir="small"
    elif [ $t == 50 ]; then
        dir="medium"
    elif [ $t == 100 ]; then
        dir="large"
    else
        dir="verylarge"
    fi
    for id in {1..525}
    do
        for i in {10..60..5}
        do
            m=$(($t*i/100))
            ./alb otto/${dir}/instance_n\=${t}_${id}.alb new/n${t}/n_${t}-m_${m}-id_${id}.alb ${t} ${m}
        done
    done
    if [ "$(ls -1 new/n${t} | wc -l)" -eq 5775 ]; then
      echo $dir ok
    else
      echo issue generating ${t}
      ls -1 new/n20 | wc -l
    fi
done
for id in {1..525}
do
    for m in 15 23 30 38 45 53 60 68 75 83 90
    do
        ./alb otto/verylarge/instance_n\=1000_${id}.alb new/n150/n_150-m_${m}-id_${id}.alb 150 ${m}
    done
done
if [ "$(ls -1 new/n150 | wc -l)" -eq 5775 ]; then
  echo ok 150 tasks
else
  echo issue generating 150 tasks
fi
for id in {1..525}
do
    for m in {20..120..10}
    do
        ./alb otto/verylarge/instance_n\=1000_${id}.alb new/n200/n_200-m_${m}-id_${id}.alb 200 ${m}
    done
done
if [ "$(ls -1 new/n200 | wc -l)" -eq 5775 ]; then
  echo ok 200 tasks
else
  echo issue generating 200 tasks
fi
for id in {1..525}
do
    for m in 25 38 50 63 75 88 100 113 125 138 150
    do
        ./alb otto/verylarge/instance_n\=1000_${id}.alb new/n250/n_250-m_${m}-id_${id}.alb 250 ${m}
    done
done
if [ "$(ls -1 new/n250 | wc -l)" -eq 5775 ]; then
  echo ok 250 tasks
else
  echo issue generating 250 tasks
fi
for id in {1..525}
do
    for m in {50..300..25}
    do
        ./alb otto/verylarge/instance_n\=1000_${id}.alb new/n500/n_500-m_${m}-id_${id}.alb 500 ${m}
    done
done
if [ "$(ls -1 new/n500 | wc -l)" -eq 5775 ]; then
  echo ok 500 tasks
else
  echo issue generating 500 tasks
fi

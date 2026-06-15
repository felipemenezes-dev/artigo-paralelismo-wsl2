#!/bin/bash

echo "threads,events_per_second" > resultados.csv

for t in 1 2 4 8
do
    for i in {1..30}
    do
        sysbench cpu \
        --threads=$t \
        --cpu-max-prime=20000 \
        run | grep "events per second" | awk -v th=$t '{print th "," $4}' >> resultados.csv
    done
done

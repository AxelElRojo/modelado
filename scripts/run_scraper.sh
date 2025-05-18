#!/bin/bash
for i in {1..10}
do
	python webscraper.py "$i" > "json/output_$i.json"
	sleep 3
done
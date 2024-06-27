#!/bin/bash
for pid in $(ps aux | grep '[m]player' | awk '{print $2}'); do
    kill -9 $pid
done

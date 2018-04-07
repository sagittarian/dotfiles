#!/bin/bash

tests=$(cat test_system.sh)
cd vagrant && vagrant ssh -c "$tests"

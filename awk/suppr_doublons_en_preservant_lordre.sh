#!/bin/bash

echo "cat toto"
cat toto

echo ""

echo "awk ' !x[$0]++' toto"
awk ' !x[$0]++' toto

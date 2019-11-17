#!/bin/sh

# 1. Place in root of Dirt-Samples folder
# 2. Run this file
# 3. Use generated dirt_samples.txt

find -s . -type f -iname "*.wav" | cut -c 3- > dirt_samples.txt

#!/bin/bash

git clone git@github.com:jeksterslab/manMCMedMiss.git
rm -rf "$PWD.git"
mv manMCMedMiss/.git "$PWD"
rm -rf manMCMedMiss

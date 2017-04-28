#!/bin/bash

# FIXME: Find a way to pin these to a particular commit maybe?
git clone --depth=1 https://github.com/data-8/tables-notebooks.git examples

# Sparse checkout of just index.ipynb and the notebooks folder in textbook repo.
mkdir /home/jovyan/textbook 
cd /home/jovyan/textbook
git init 
git config core.sparseCheckout true
git remote add -f origin https://github.com/data-8/textbook.git
echo "notebooks/*" >> .git/info/sparse-checkout
echo "index.ipynb" >> .git/info/sparse-checkout
git checkout gh-pages

# Sparse checkout of notebooks from data8assets.
mkdir /home/jovyan/assignments
cd /home/jovyan/assignments
git init
git config core.sparseCheckout true
git remote add -f origin https://github.com/data-8/data8assets.git
echo "materials/sp17/*" >> .git/info/sparse-checkout
echo "lec/sp17/*" >> .git/info/sparse-checkout
git checkout gh-pages
 

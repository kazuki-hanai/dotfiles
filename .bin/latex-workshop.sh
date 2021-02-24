#!/bin/bash

echo $PWD

for file in $( ls . | grep .tex$ ); do
        TEX_FILE=`echo $file | sed "s/\.tex\$//"`
        docker run --rm -v $PWD:/workdir paperist/alpine-texlive-ja uplatex $TEX_FILE.tex
        docker run --rm -v $PWD:/workdir paperist/alpine-texlive-ja upbibtex $TEX_FILE
        docker run --rm -v $PWD:/workdir paperist/alpine-texlive-ja uplatex $TEX_FILE.tex
        docker run --rm -v $PWD:/workdir paperist/alpine-texlive-ja uplatex $TEX_FILE.tex
        docker run --rm -v $PWD:/workdir paperist/alpine-texlive-ja dvipdfmx $TEX_FILE.dvi
done

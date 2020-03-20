#!/bin/bash

# precisa do texlive: sudo apt install texlive-full

# variables
data=$(date +%Y%m%d_%H%M%S)
dir_versao=~/Dropbox/Fatec/Sem6-022015/TG/Versoes/TG.v.$data

# functions
function build {
    pdflatex monografia.tex; pdflatex monografia.tex;

    bibtex monografia.aux; bibtex monografia.aux;

    pdflatex monografia.tex; pdflatex monografia.tex;

    rm *.aux *.toc *.bbl *.blg *.lof *.idx *.brf
}

function gen_version {
    echo "----------------------------------------------------------------------"
    echo "versionando..."
    mkdir $dir_versao
    cp *.tex *.bib *.pdf $dir_versao
    cp -Rf img $dir_versao
    echo "done"
}

function show_usage {
    echo ""
    echo "Usage: ./compila_tex.sh [OPTION]"
    echo "OPTIONS"
    echo "    Nothing: just compile."
    echo "    V, v: generate version."
    echo "    O, o: open pdf in okular."
    echo ""
    exit 1
}

# main
build

if [ $# -ge 1 ] ; then
    if [ $1 == O ] || [ $1 == o ] ; then
        okular monografia.pdf
    fi
fi

if [ $# -ge 1 ] ; then
    if [ $1 == V ] || [ $1 == v ] ; then
        gen_version
    fi
#    elif [ $1 == U ] || [ $1 == u ] || [ $1 == H ] || [ $1 == h ]; then
fi

show_usage
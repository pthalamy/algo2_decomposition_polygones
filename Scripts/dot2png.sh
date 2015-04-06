#!/bin/bash
dot "$1" -Tpng -o "$(basename $1 .dot)".png
echo "Ouvrez $(basename $1 .dot).png pour visualiser le graph"


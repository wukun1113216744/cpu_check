#!/bin/sh

HELP='$1:time(s) $2output_file.svg'

if [[ $1 == "help" || $1 == "--help" || $1 == "-h" || $1 == ""  ]]; then
	echo "$HELP"
	exit
fi
perf record -F 99 -g --call-graph=dwarf &
sleep $1
killall perf
sleep 1
perf script > out.perf
FlameGraph/stackcollapse-perf.pl out.perf > out.folded
FlameGraph/flamegraph.pl out.folded > $2


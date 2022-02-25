#!/usr/bin/perl

use warnings;

open LOGDATA, '<', $ARGV[0] or die;

my %stats;

$stats{"[A]0-10ms"}{min} = 0;
$stats{"[A]0-10ms"}{max} = 10;

$stats{"[B]10-20ms"}{min} = 11;
$stats{"[B]10-20ms"}{max} = 20;

$stats{"[C]20-30ms"}{min} = 21;
$stats{"[C]20-30ms"}{max} = 30;

$stats{"[D]30-50ms"}{min} = 31;
$stats{"[D]30-50ms"}{max} = 50;

$stats{"[E]50-80ms"}{min} = 51;
$stats{"[E]50-80ms"}{max} = 80;

$stats{"[F]80-100ms"}{min} = 81;
$stats{"[F]80-100ms"}{max} = 100;

$stats{"[G]100-120ms"}{min} = 101;
$stats{"[G]100-120ms"}{max} = 120;

$stats{"[H]120-150ms"}{min} = 121;
$stats{"[H]120-150ms"}{max} = 150;

$stats{"[I]150-200ms"}{min} = 151;
$stats{"[I]150-200ms"}{max} = 200;

$stats{"[J]200-300ms"}{min} = 201;
$stats{"[J]200-300ms"}{max} = 300;

$stats{"[K]300-500ms"}{min} = 301;
$stats{"[K]300-500ms"}{max} = 500;

$stats{"[L]500ms"}{min} = 501;
$stats{"[L]500ms"}{max} = 9999999;

$stats{"[Z]all"}{min} = 0;
$stats{"[Z]all"}{max} = 9999999;

foreach $k (keys %stats) {
	$stats{$k}{count} = 0;
	$stats{$k}{time}  = 0;
}

while (<LOGDATA>) {
	$line = $_;
	chomp $line;

	if ($line =~ / (?<th>(\d+))\/(?<ti>(\d+))\/(?<tR>(\d+))\/(?<tw>(\d+))\/(?<tc>(\d+))\/(?<tr>(\d+))\/(?<td>(\d+))\/(?<ta>(\d+)) /) {
		$th = $+{th};
		$ti = $+{ti};
		$tR = $+{tR};
		$tw = $+{tw};
		$tc = $+{tc};
		$tr = $+{tr};
		$td = $+{td};
		$ta = $+{ta};

		if ($th < 0 || $ti < 0 || $tR < 0 || $tw < 0 || $tc < 0 || $tr < 0 || $td < 0 || $ta < 0) {
			next;
		}

		$t5 = $tR;

		if ($t5 < 0) {
			next;
		}

		foreach $k (keys %stats) {
			if ($t5 >= $stats{$k}{min} &&
			    $t5 <= $stats{$k}{max}) {
				$stats{$k}{count}++;
				$stats{$k}{time} += $t5;
			}
		}
	}
}

foreach $k (sort keys %stats) {
	if ($stats{$k}{count} == 0) {
		next;
	}
	printf "%-13s:",       $k;
	printf "count:%8d  ",  $stats{$k}{count};
	printf "%6.2f%%  ",    $stats{$k}{count}/$stats{"[Z]all"}{count}*100;
	printf "time:%11d  ",  $stats{$k}{time};
	printf "%6.2f%%  ",    $stats{$k}{time}/$stats{"[Z]all"}{time}*100;
	printf "avg: %d  ",    $stats{$k}{time}/$stats{$k}{count};
	printf "\n";
}

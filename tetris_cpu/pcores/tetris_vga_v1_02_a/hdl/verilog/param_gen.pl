#!/usr/bin/perl

$y=6;
$x=6;

for ($i=0; $i<20; $i++) {
    for ($j=0; $j<10; $j++) {
        print "GAME_TILE_".(10*$i+$j)."		= {6'd$x, 6'd$y},\n";
        $x++;
    }
    $x=6;
    $y++;
}



#!/usr/bin/perl

# Skrypt do losowego pobieania tapet z http://strims.pl/s/Tapety
# Uwzględnia dwie ostatnie strony wyników

use strict;
use warnings;
use LWP::Simple;

my $stapety = "http://strims.pl/s/Tapety?strona=1%2C2";
my $strimsurl = 'http://strims.pl/';
my $tregex = 't/[A-Za-z0-9]{6}/';

my $html = get $stapety;
my @links = $html =~ m/$tregex/g;
my $randlink = $links[rand @links];
my $stap = get $strimsurl.$randlink;
if($stap =~ m/(http\:\/\/i\.imgur\.com\/[A-Za-z0-9]+\.(png|jpg))/){
	getstore($1, "tapeta.".substr($1, -3));
}
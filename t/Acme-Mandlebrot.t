#!perl
use strict;
use Test::More tests => 25;


BEGIN { use_ok( 'Acme::Mandlebrot' ) }

my $mandlebrot_default = Acme::Mandlebrot->new();

is(ref($mandlebrot_default),'Acme::Mandlebrot','Returns appropriate object');
ok($mandlebrot_default->can('width'));
is($mandlebrot_default->width(),640,'Default width is 640');

my $mandlebrot_tiny = Acme::Mandlebrot->new({ width=>4, height=>3 });

is(ref($mandlebrot_tiny),'Acme::Mandlebrot','Returns appropriate object');
ok($mandlebrot_tiny->can('width'));
is($mandlebrot_tiny->width(),4,'Width is 4');

my @correct_tiny_block = ( 0, 0, 0, 2, 20, 2, 4, 20, 2, 1, 1, 1 );

my $cnt = -1;
for ($mandlebrot_tiny->process_block()) {
  for (@$_) {
    $cnt++;
    is($correct_tiny_block[$cnt], $_)
  }
}

$cnt = -1;

for ($mandlebrot_tiny->process_block(0,0,1,2)) {
  for (@$_) {
    $cnt++;
    is($correct_tiny_block[$cnt], $_)
  }
}






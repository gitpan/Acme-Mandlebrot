package Acme::Mandlebrot;

use strict;
use warnings;

use Class::MethodMaker get_set => [qw( max_iterations width height )];

our $VERSION='0.02';

sub new {
  my $class = shift;
  my ($self) = @_;

  $self->{max_iterations} ||=   20;
  $self->{width}          ||=  640;
  $self->{height}         ||=  480;
  $self->{min_real}       ||= -2.0;
  $self->{max_real}       ||=  1.0;
  $self->{min_imaginary}  ||= -1.2;
  $self->{max_imaginary}  ||= $self->{min_imaginary} + ($self->{max_real} - $self->{min_real}) * $self->{height}/$self->{width};

  $self->{real_factor}      = ($self->{max_real}      - $self->{min_real}     ) / ($self->{width}  - 1);
  $self->{imaginary_factor}  = ($self->{max_imaginary} - $self->{min_imaginary}) / ($self->{height} - 1);

  return bless $self,$class;
}

sub process_block {
  my $self = shift;
  my($x1,$y1,$x2,$y2) = @_;
  if (!(defined($x1))) {
    $x1 = 0;
    $y1 = 0;
    $x2 = $self->{width}  - 1;
    $y2 = $self->{height} - 1;
  }
  my @results = ();

  foreach my $x ($x1..$x2) {
    my $c_r = $self->{min_real} + $x*$self->{real_factor};
    foreach my $y ($y1..$y2) {
      my $c_i = $self->{max_imaginary} - $y * $self->{imaginary_factor};

      my $z_i = $c_i;
      my $z_r = $c_r;
      my $iterations;

      foreach my $n (0..$self->{max_iterations}) {
        $iterations = $n;
        my $z2_r = $z_r*$z_r;
        my $z2_i = $z_i*$z_i;
        if($z2_r + $z2_i > 4) {
          last;
        }
        $z_i = 2*$z_r*$z_i + $c_i;
        $z_r = $z2_r - $z2_i + $c_r;
      }
      $results[$x][$y] = $iterations;
    }
  }
  return @results;
}

1;

__END__

=pod

=head1 NAME

Acme::Mandlebrot

=head1 SYNOPSIS

  use Acme::Mandlebrot;

  my $mandlebrot = Acme::Mandlebrot->new({width => 640, height => 480});
  my @results = $mandlebrot->process_block();

  # do some colour of the results and ooh and ah at the pretty picture

=head1 DESCRIPTION

Acme::Mandlebrot generates mandlebrot sets.

=head1 TODO

More documentation, some more examples and an xs version.

=head1 KUDOS

Dave Steiner for spotting where i'd been sloppy and left something from a previous incarnation in
the gd example.

=head1 AUTHOR

Greg McCarroll <greg@mccarroll.demon.co.uk>

=cut




use ExtUtils::MakeMaker;
my $module = 'Mandlebrot.pm';
WriteMakefile(
              NAME         => 'Acme::Mandlebrot',
              VERSION_FROM => $module,
              PREREQ_PM    => {
                               Test::More => 0,
                                Class::MethodMaker => 0,
                              },
              AUTHOR       => 'Greg McCarroll <greg@mccarroll.demon.co.uk>',
             );



use Module::Build;

my $build = Module::Build->new(
    module_name   => 'Perl::Tidy::Sweetend',
    license       => 'perl',
    create_readme => 1,
    script_files  => [qw(script/perltidier)],
    requires      => {
        'perl'              => '5.008',
        'Perl::Tidy' => 0,
    },
    build_requires => {
        'Test::Differences' => 0,
        'Test::More'        => 0.87,
    },
    configure_requires => { 'Module::Build' => '0.36', },
    meta_merge => {
        resources => {
            bugtracker =>
              'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Perl-Tidy-Sweetend',
            repository => 'http://github.com/mvgrimes/perl-tidy-sweetend'
        }
    },
);

$build->create_build_script;

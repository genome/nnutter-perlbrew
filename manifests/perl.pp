# == Class: perlbrew::perl
#
# This class installs a version of Perl using Perlbrew.
#
# === Parameters
#
# [*version*]
#   The Perlbrew interpreter version to install.  Due to poor implementation
#   the title of the resource should also be its version.
#
# [*compile_options*]
#   Option flags to use when compiling the interpreter.

define perlbrew::perl (
  $version         = '5.16.3',
  $compile_options = [],
) {
  include perlbrew

  if (is_array($compile_options)) {
    $compile_opts = join($compile_options, ' ')
  }

  exec { "install_perl_${version}":
    environment => [
      "PERLBREW_ROOT=${perlbrew::perlbrew_root}",
      'PERLBREW_HOME=/tmp/.perlbrew',
      'HOME=/opt',
    ],
    command     => "/bin/bash -c '. ${perlbrew::perlbrew_root}/etc/bashrc; ${perlbrew::perlbrew_root}/bin/perlbrew install perl-${version} ${compile_opts}'",
    creates     => "${perlbrew::perlbrew_root}/perls/perl-${version}/bin/perl",
    provider    => shell,
    timeout     => 0,
    require     => Class['perlbrew'],
  }
}

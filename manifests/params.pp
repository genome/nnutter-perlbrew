# == Class: perlbrew::params
#
# This class includes the default parameters for the Perlbrew class.
#
# === Variables
#
# [*perlbrew_root*]
#   Specifies the root of your perlbew installation, e.g. '/opt/perl5'.
#
# [*cpanm*]
#   Specifies the path to Perlbrew's `cpanm`.
#
# [*bin*]
#   Specifies the path to `perlbrew`.


class perlbrew::params {
  case $::osfamily {
    'Debian': {
      $perlbrew_root      = '/opt/perl5'
      $perlbrew_init_file = '/etc/profile.d/perlbrew.sh'
    }
    'RedHat': {
      $perlbrew_root      = '/opt/perl5'
      $perlbrew_init_file = '/etc/profile.d/perlbrew.sh'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  $cpanm = "${perlbrew_root}/bin/cpanm"
  $bin = "${perlbrew_root}/bin/perlbrew"
}

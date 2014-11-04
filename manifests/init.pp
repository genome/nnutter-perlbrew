# == Class: perlbrew
#
# This class installs and configures perlbrew.
# It does not install any versions of Perl by default.

class perlbrew (
  $perlbrew_root      = $perlbrew::params::perlbrew_root,
  $perlbrew_init_file = $perlbrew::params::perlbrew_init_file,
  $cpanm              = $perlbrew::params::cpanm,
  $bin                = $perlbrew::params::bin,
) inherits perlbrew::params {
  class { 'perlbrew::install': }
  class { 'perlbrew::config':
    require => Class['perlbrew::install'],
  }
  anchor { 'perlbrew::end':
    require => Class['perlbrew::install', 'perlbrew::config'],
  }
}

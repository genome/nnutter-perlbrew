# == Class: perlbrew::install
#
# This class installs Perlbrew and is meant to be called from perlbrew
#
class perlbrew::install {
  if !defined(Package['curl']) {
    package { 'curl':
      ensure => present,
    }
  }

  file { $perlbrew::perlbrew_root :
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  exec { 'install_perlbrew':
    environment => [
      "PERLBREW_ROOT=${perlbrew::perlbrew_root}",
    ],
    command     => '/usr/bin/curl -L http://install.perlbrew.pl | /bin/bash',
    creates     => $perlbrew::bin,
    require     => Package['curl'],
  }

  exec { 'install_cpanm':
    environment => [
      "PERLBREW_ROOT=${perlbrew::perlbrew_root}",
    ],
    command     => "${perlbrew::bin} install-cpanm",
    creates     => $perlbrew::cpanm,
    logoutput   => true,
    require     => Exec['install_perlbrew'],
  }
}

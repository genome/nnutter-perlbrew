# == Class: perlbrew::config
#
# This class configures Perlbrew and is meant to be called from perlbrew.
#
class perlbrew::config {
  file { $perlbrew::perlbrew_init_file :
    ensure  => present,
    content => template('perlbrew/perlbrew.sh.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}

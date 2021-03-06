# == Define:: perlbrew::perl::ssl
#
# "Extends" `perlbrew::perl` to also install SSL modules for CPAN.

define perlbrew::perl::ssl (
  $version         = '5.16.3',
  $compile_options = [],
) {
  include perlbrew

  $ssl_dev = 'libssl-dev'
  package { $ssl_dev :
    ensure => installed,
  }

  perlbrew::perl { $version :
    version         => $version,
    compile_options => $compile_options,
  }

  perlbrew::cpan::module { "Bundle::LWP-${version}":
    module  => 'Bundle::LWP',
    perl_version => $version,
  }

  perlbrew::cpan::module { "Crypt::SSLeay-${version}":
    module  => 'Crypt::SSLeay',
    perl_version => $version,
    require      => [
      Package[$ssl_dev],
      Perlbrew::Cpan::Module["Bundle::LWP-${version}"],
    ],
  }
}

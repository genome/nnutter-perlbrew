# == Define: perlbrew::carton
#
# Using an already installed Perlbrew interpreter this ensures Carton is
# installed and runs `carton install` in the specified directory whenever this
# resource is notified.
#
# === Parameters
#
# [*perl_version*]
#   The Perlbrew interpreter to use when running `carton`.
#
# [*version*]
#   The version of Carton to install.  Defaults to latest version.
#
# [*carton_dir*]
#   The directory to run `carton install` in.  The `local` subdirectory will be
#   created here and your `cpanfile` should be in here.  Uses the resource
#   title as the default.
#
# === Examples
#
# perlbrew::carton { '/some/directory':
#   perl_version => '5.20.1',
#   subscribe    => Vcsrepo['/some/directory'],
# }

define perlbrew::carton (
  $perl_version,
  $version = '',
  $carton_dir  = $title,
) {
  perlbrew::cpan::module { "${title}-carton-module":
    module       => 'Carton',
    version      => $version,
    perl_version => $perl_version,
  }

  exec { "${title}-trigger-carton-install":
    cwd     => $carton_dir,
    command => '/bin/true',
    onlyif  => '/usr/bin/test .carton-installed -ot cpanfile',
    notify  => Perlbrew::Exec["${title}-carton-install"],
  }

  perlbrew::exec { "${title}-carton-install":
    perl_version => $perl_version,
    cwd          => $carton_dir,
    command      => 'carton install && touch .carton-installed',
    refreshonly  => true,
    timeout      => 0,
    require      => Perlbrew::Cpan::Module["${title}-carton-module"],
  }
}


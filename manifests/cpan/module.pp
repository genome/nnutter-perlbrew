# == Define: perlbrew::cpan::module
#
# Installs a CPAN module using an already installed Perlbrew interpreter.
#
# === Parameters
#
# [*perl_version*]
#   The Perlbrew interpreter to use when running `carton`.
#
# [*module*]
#   Name of the CPAN module.  Defaults to title of resource.
#
# [*version*]
#   Version of the CPAN module.  Effectively defaults to "present".
#
# === Examples
#
# perlbrew::cpan::module { 'Task::Kensho':
#   perl_version => '5.20.1',
# }

define perlbrew::cpan::module (
  $perl_version,
  $module = $title,
  $version = '',
) {
  if ($version) {
    $command_title = "cpanm-${perl_version}-${module}-${version}"
    $module_expr = "${module}@${version}"
    $unless = "perl -M${module} -e 'use strict; use warnings; exit(\$${module}::VERSION ne q(${version}))'"
  } else {
    $command_title = "cpanm-${perl_version}-${module}"
    $module_expr = $module
    $unless = "perl -M${module} -e 1"
  }

  perlbrew::exec { $command_title :
    perl_version => $perl_version,
    command      => "cpanm ${module_expr}",
    unless       => $unless,
    timeout      => 600,
  }
}

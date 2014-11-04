# == Define: perlbrew::exec
#
# Wrapper around `exec` to facilitate running `perlbrew exec` with already
# installed Perlbrew interpreters.  Not all `exec` parameters are recognized
# yet.
#
# Be aware that `perlbrew exec` return a zero exit code under some uses that
# you may consider failure; for example, specifying an invalid interpreter
# version.
#
# === Parameters
#
# [*perl_version*]
#   The Perlbrew interpreter to use when running `carton`.
#
# [*command*]
#   This command will be passed to `perlbrew exec` for execution.

define perlbrew::exec (
  $perl_version,
  $command,
  $cwd = undef,
  $environment = [],
  $refreshonly = false,
  $timeout = 300,
  $unless = undef,
) {
  $perlbrew_env = [
    "PERLBREW_ROOT=${perlbrew::perlbrew_root}",
  ]
  $full_environment = concat($perlbrew_env, $environment)
  $full_command = "${perlbrew::bin} exec --with ${perl_version} ${command}"

  if $unless {
    $full_unless = "${perlbrew::bin} exec --with ${perl_version} ${unless}"
  } else {
    $full_unless = undef
  }
  exec { $title :
    command     => $full_command,
    cwd         => $cwd,
    environment => $full_environment,
    refreshonly => $refreshonly,
    timeout     => $timeout,
    unless      => $full_unless,
    require     => Perlbrew::Perl[$perl_version],
  }
}

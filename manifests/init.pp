# == Class: atop
#
# Allow to install and configure atop.
#
# === Parameters
#
# [*package_name*]
#   Package name, default to atop.
#
# [*service_name*]
#   Service name, default to atop.
#
# [*service*]
#   Enable atop service, default to false.
#
# [*interval*]
#   Interval between snapshots, default to 600.
#
# [*logpath*]
#   Directory were the log will be saved by the service.
#   Default is /var/log/atop.
class atop (
  $package_name = $atop::params::package_name,
  $service_name = $atop::params::service_name,
  $service = $atop::params::service,
  $interval = $atop::params::interval,
  $logpath = $atop::params::logpath,
) inherits atop::params {
  $service_state = $service ? {
    true    => 'running',
    default => 'stopped',
  }

  package { $package_name:
    ensure => 'installed',
  } ->
  file { $conf_file:
    ensure  => 'file',
    owner   => $conf_file_owner,
    group   => $conf_file_group,
    mode    => $conf_file_mode,
    content => template($conf_file_template),
    notify  => Service[$service_name],
  } ->
  service { $service_name:
    ensure => $service_state,
    enable => $service,
  }
}

# vim: set et sw=2:

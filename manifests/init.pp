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
  $keepdays = $atop::params::keepdays
) inherits atop::params {
  $service_state = $service ? {
    true    => 'running',
    default => 'stopped',
  }

  package { $package_name:
    ensure => 'installed',
  } ->
  file { $atop::params::conf_file:
    ensure  => 'file',
    owner   => $atop::params::conf_file_owner,
    group   => $atop::params::conf_file_group,
    mode    => $atop::params::conf_file_mode,
    content => template($atop::params::conf_file_template),
  } ->
  service { $service_name:
    ensure => $service_state,
    enable => $service,
  }
  if (defined $keepdays) {
      cron {
        'remove_atop':
            hour    => '21',
            minute  => '13',
            command => "/usr/bin/find ${logpath} -maxdepth 1 -mount -name atop_20* -mtime +${keepdays} -delete",
            user    => 'root';
      }
      file {
        '/etc/logrotate.d/atop':
            ensure => absent
      }
  }
}

# vim: set et sw=2:

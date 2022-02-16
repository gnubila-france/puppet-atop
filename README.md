puppet-atop
===========

Puppet module for managing atop.

Project home https://github.com/tobixen/puppet-atop

This is a fork of https://github.com/gnubila-france/puppet-atop which seems not to be maintained

This module has only been tested in a specific environment and may have unmapped dependencies, i.e. cron is used rather than systemd timers.  The HEAD version has only been tested towards SL7 and Bionic.

Tested under:
* Scientific Linux 5
* Scientific Linux 6
* CentOS 6
* Ubuntu Bionic
* Debian Wheezy
* Archlinux

## Usage

Install atop and disable service.

``` ruby
class { 'atop': }
```

Install atop, configure and enable service.

``` ruby
class { 'atop':
  service  => true,
  interval => 120,
}
```

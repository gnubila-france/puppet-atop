puppet-atop
===========

[![Puppet Forge](http://img.shields.io/puppetforge/v/gnubilafrance/atop.svg)](https://forge.puppetlabs.com/gnubilafrance/atop)
[![Build Status](https://travis-ci.org/gnubila-france/puppet-atop.png?branch=master)](https://travis-ci.org/gnubila-france/puppet-atop)

Puppet module for managing atop.

Tested under:
* Scientific Linux 5
* Scientific Linux 6
* CentOS 6
* Centos 7
* Debian Wheezy

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

# == Class: puppetmaster::environment
#
# This class configures Puppet Master environments
#
# === Parameters
#
# [*puppetmaster_environment*]
#   Defines the environment name
#
# [*puppetmaster_modulepath*]
#   Defines the module path.
#
# [*puppetmaster_manifestdir*]
#   Defines the manifest dir.
#
# [*puppetmaster_manifest*]
#   Defines the manifest.
#
# [*puppetmaster_templatedir*]
#   Defines the templatedir.
#
# === Variables
#
# === Examples
#
#  class { puppetmaster::environment:
#    puppetmaster_environment          => 'staging',
#    puppetmaster_modulepath           => '$confdir/envionments/$environment/modules',
#    puppetmaster_manifestdir          => '$confdir/envionments/$environment/manifests',
#    puppetmaster_manifest             => '$confdir/envionments/$environment/manifests/site.pp',
#    puppetmaster_templatedir          => '$confdir/envionments/$environment/templatedir',
#  }
#
# === Authors
#
# Felipe Salum <fsalum@gmail.com>
# Rajul Vora <rvora@cloudopia.co>
#
# === Copyright
#
# Copyright 2012 Felipe Salum, unless otherwise noted.
#
class puppetmaster::environment (
  $puppetmaster_environment          = '',
  $puppetmaster_modulepath           = '',
  $puppetmaster_manifestdir          = '',
  $puppetmaster_manifest             = '',
  $puppetmaster_templatedir          = '',
) {

  # fail unless environment name is defined
  if ! $puppetmaster_environment {
    fail('puppetmaster_environment is required argument')
  }

  Ini_setting {
    path    => '/etc/puppet/puppet.conf',
    ensure  => present,
  }

  if ($puppetmaster_modulepath) {
    ini_setting { "${puppetmaster_environment}_puppetmaster_modulepath":
      section => $puppetmaster_environment,
      setting => 'modulepath',
      value   => $puppetmaster_modulepath,
    }
  }

  if ($puppetmaster_manifestdir) {
    ini_setting { "${puppetmaster_environment}_puppetmaster_manifestdir":
      section => $puppetmaster_environment,
      setting => 'manifestdir',
      value   => $puppetmaster_manifestdir,
    }
  }

  if ($puppetmaster_manifest) {
    ini_setting { "${puppetmaster_environment}_puppetmaster_manifest":
      section => $puppetmaster_environment,
      setting => 'manifest',
      value   => $puppetmaster_manifest,
    }
  }

  if ($puppetmaster_templatedir) {
    ini_setting { "${puppetmaster_environment}_puppetmaster_templatedir":
      section => $puppetmaster_environment,
      setting => 'templatedir',
      value   => $puppetmaster_templatedir,
    }
  }

}

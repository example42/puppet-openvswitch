# Class: openvswitch::params
#
# Defines all the variables used in the module.
#
class openvswitch::params {

  $extra_package_name = undef

  $package_name = $::osfamily ? {
    default  => 'openvswitch-switch',
  }

  $service_name = $::osfamily ? {
    default  => 'openvswitch-switch',
  }

  $config_file_path = $::osfamily ? {
    default => '/etc/openvswitch/openvswitch.conf',
  }

  $config_file_mode = $::osfamily ? {
    default => '0644',
  }

  $config_file_owner = $::osfamily ? {
    default => 'root',
  }

  $config_file_group = $::osfamily ? {
    default => 'root',
  }

  $config_dir_path = $::osfamily ? {
    default => '/etc/openvswitch',
  }

  case $::osfamily {
    'Debian','RedHat','Amazon': { }
    default: {
      fail("${::operatingsystem} not supported. Review params.pp for extending support.")
    }
  }
}

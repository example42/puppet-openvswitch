# Class: openvswitch::params
#
# Defines all the variables used in the module.
#
class openvswitch::params {

  $extra_package_name = $::osfamily ? {
    default  => 'python-openvswitch',
  }

  $package_name = $::osfamily ? {
    'Redhat' => 'openstack-openvswitch',
    default  => 'openvswitch',
  }

  $service_name = $::osfamily ? {
    'Redhat' => 'openstack-openvswitch-api',
    default  => 'openvswitch-api',
  }

  $registry_service_name = $::osfamily ? {
    'Redhat' => 'openstack-openvswitch-registry',
    default  => 'openvswitch-registry',
  }

  $config_file_path = $::osfamily ? {
    default => '/etc/openvswitch/openvswitch-api.conf',
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

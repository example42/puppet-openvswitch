#
# = Class: openvswitch
#
# This class installs and manages openvswitch
#
#
# == Parameters
#
# Refer to https://github.com/stdmod for official documentation
# on the stdmod parameters used
#
class openvswitch (

  $extra_package_name        = $openvswitch::params::extra_package_name,

  $package_name              = $openvswitch::params::package_name,
  $package_ensure            = 'present',

  $service_name              = $openvswitch::params::service_name,
  $service_ensure            = 'running',
  $service_enable            = true,

  $registry_service_name     = $openvswitch::params::registry_service_name,

  $config_file_path          = $openvswitch::params::config_file_path,
  $config_file_replace       = $openvswitch::params::config_file_replace,
  $config_file_require       = 'Package[openvswitch]',
  $config_file_notify        = 'Service[openvswitch]',
  $config_file_source        = undef,
  $config_file_template      = undef,
  $config_file_content       = undef,
  $config_file_options_hash  = undef,


  $config_dir_path           = $openvswitch::params::config_dir_path,
  $config_dir_source         = undef,
  $config_dir_purge          = false,
  $config_dir_recurse        = true,

  $dependency_class          = undef,
  $my_class                  = undef,

  $monitor_class             = undef,
  $monitor_options_hash      = { } ,

  $firewall_class            = undef,
  $firewall_options_hash     = { } ,

  $scope_hash_filter         = '(uptime.*|timestamp)',

  $tcp_port                  = undef,
  $udp_port                  = undef,

  ) inherits openvswitch::params {


  # Class variables validation and management

  validate_bool($service_enable)
  validate_bool($config_dir_recurse)
  validate_bool($config_dir_purge)
  if $config_file_options_hash { validate_hash($config_file_options_hash) }
  if $monitor_options_hash { validate_hash($monitor_options_hash) }
  if $firewall_options_hash { validate_hash($firewall_options_hash) }

  $config_file_owner          = $openvswitch::params::config_file_owner
  $config_file_group          = $openvswitch::params::config_file_group
  $config_file_mode           = $openvswitch::params::config_file_mode

  $manage_config_file_content = default_content($config_file_content, $config_file_template)

  $manage_config_file_notify = pickx($config_file_notify)

  if $package_ensure == 'absent' {
    $manage_service_enable = undef
    $manage_service_ensure = stopped
    $config_dir_ensure = absent
    $config_file_ensure = absent
  } else {
    $manage_service_enable = $service_enable
    $manage_service_ensure = $service_ensure
    $config_dir_ensure = directory
    $config_file_ensure = present
  }


  # Resources managed

  if $openvswitch::package_name {
    package { $openvswitch::package_name:
      ensure   => $openvswitch::package_ensure,
    }
  }

  if $openvswitch::extra_package_name {
    package { $openvswitch::extra_package_name:
      ensure   => $openvswitch::package_ensure,
    }
  }

  if $openvswitch::service_name {
    service { $openvswitch::service_name:
      ensure     => $openvswitch::manage_service_ensure,
      enable     => $openvswitch::manage_service_enable,
    }
    service { $openvswitch::registry_service_name:
      ensure     => $openvswitch::manage_service_ensure,
      enable     => $openvswitch::manage_service_enable,
    }
  }

  if $openvswitch::config_file_path {
    file { 'openvswitch.conf':
      ensure  => $openvswitch::config_file_ensure,
      path    => $openvswitch::config_file_path,
      mode    => $openvswitch::config_file_mode,
      owner   => $openvswitch::config_file_owner,
      group   => $openvswitch::config_file_group,
      source  => $openvswitch::config_file_source,
      content => $openvswitch::manage_config_file_content,
      notify  => $openvswitch::manage_config_file_notify,
      require => $openvswitch::config_file_require,
    }
  }

  if $openvswitch::config_dir_source {
    file { 'openvswitch.dir':
      ensure  => $openvswitch::config_dir_ensure,
      path    => $openvswitch::config_dir_path,
      source  => $openvswitch::config_dir_source,
      recurse => $openvswitch::config_dir_recurse,
      purge   => $openvswitch::config_dir_purge,
      force   => $openvswitch::config_dir_purge,
      notify  => $openvswitch::config_file_notify,
      require => $openvswitch::config_file_require,
    }
  }


  # Extra classes

  if $openvswitch::dependency_class {
    include $openvswitch::dependency_class
  }

  if $openvswitch::my_class {
    include $openvswitch::my_class
  }

  if $openvswitch::monitor_class {
    class { $openvswitch::monitor_class:
      options_hash => $openvswitch::monitor_options_hash,
      scope_hash   => {}, # TODO: Find a good way to inject class' scope
    }
  }

  if $openvswitch::firewall_class {
    class { $openvswitch::firewall_class:
      options_hash => $openvswitch::firewall_options_hash,
      scope_hash   => {},
    }
  }

}


# Class: openvswitch::params
#
# This class defines default parameters used by the main module class openvswitch
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to openvswitch class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class openvswitch::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'openvswitch-switch',
  }

  $service = $::operatingsystem ? {
    default => 'openvswitch-switch',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'ovs-vswitchd',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'openvswitch',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/openvswitch',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/openvswitch/openvswitch.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/openvswitch-switch',
    default                   => '/etc/sysconfig/openvswitch-switch',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/openvswitch.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/openvswitch',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/openvswitch',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/openvswitch/openvswitch.log',
  }

  $port = ''
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = undef

}

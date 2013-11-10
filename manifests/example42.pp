# = Class: openvswitch::example42
#
# Example42 puppi additions. To add them set:
#   my_class => 'openvswitch::example42'
#
class openvswitch::example42 {

  puppi::info::module { 'openvswitch':
    packagename => $openvswitch::package_name,
    servicename => $openvswitch::service_name,
    processname => 'openvswitch',
    configfile  => $openvswitch::config_file_path,
    configdir   => $openvswitch::config_dir_path,
    pidfile     => '/var/run/openvswitch.pid',
    datadir     => '',
    logdir      => '/var/log/openvswitch',
    protocol    => 'tcp',
    port        => '5000',
    description => 'What Puppet knows about openvswitch' ,
    # run         => 'openvswitch -V###',
  }

  puppi::log { 'openvswitch':
    description => 'Logs of openvswitch',
    log         => [ '/var/log/openvswitch/api.log' , '/var/log/openvswitch/registry.log' ],
  }

}

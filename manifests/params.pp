# Class: c_icap::params
#
# This class defines default parameters used by the main module class c_icap
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to c_icap class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class c_icap::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'c-icap',
  }

  $module_package_prefix = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'libc-icap-mod-',
    default                   => '',
  }

  $module_package_suffix = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '',
    default                   => '',
  }

  $service = $::operatingsystem ? {
    default => 'c-icap',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'c-icap',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'c-icap',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/c-icap',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/c-icap/c-icap.conf',
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
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/c-icap',
    /(?i:Archlinux)/          => '/etc/conf.d/c-icap',
    default                   => false, # '/etc/sysconfig/c-icap' ?
  }

  $init_template = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'c_icap/c-icap.init.Debian.erb',
    /(?i:Archlinux)/          => 'c_icap/c-icap.init.Archlinux.erb',
    default                   => undef,
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/c-icap/c-icap.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/var/tmp',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/c-icap',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/c-icap/server.log',
  }

  $port = '1344'
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
  $noops = false

}

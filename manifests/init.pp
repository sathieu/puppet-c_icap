# = Class: c_icap
#
# This is the main c-icap class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, c_icap class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $c_icap_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, c_icap main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $c_icap_source
#
# [*source_dir*]
#   If defined, the whole c_icap configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $c_icap_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $c_icap_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, c_icap main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $c_icap_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $c_icap_options
#
# [*service_autorestart*]
#   Automatically restarts the c_icap service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $c_icap_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $c_icap_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $c_icap_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $c_icap_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for c_icap checks
#   Can be defined also by the (top scope) variables $c_icap_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $c_icap_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $c_icap_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $c_icap_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $c_icap_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for c_icap port(s)
#   Can be defined also by the (top scope) variables $c_icap_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling c_icap. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $c_icap_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $c_icap_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $c_icap_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $c_icap_audit_only
#   and $audit_only
#
# Default class params - As defined in c_icap::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of c_icap package
#
# [*service*]
#   The name of c_icap service
#
# [*service_status*]
#   If the c_icap service init script supports status argument
#
# [*process*]
#   The name of c_icap process
#
# [*process_args*]
#   The name of c_icap arguments. Used by puppi and monitor.
#   Used only in case the c_icap process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user c_icap runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*accesslog_file*]
#   Access log file
#
# [*modules_dir*]
#   Module/Plugin directory
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $c_icap_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $c_icap_protocol
#
#
# See README for usage patterns.
#
class c_icap (
  $my_class              = params_lookup( 'my_class' ),
  $source                = params_lookup( 'source' ),
  $source_dir            = params_lookup( 'source_dir' ),
  $source_dir_purge      = params_lookup( 'source_dir_purge' ),
  $template              = params_lookup( 'template' ),
  $service_autorestart   = params_lookup( 'service_autorestart' , 'global' ),
  $options               = params_lookup( 'options' ),
  $version               = params_lookup( 'version' ),
  $absent                = params_lookup( 'absent' ),
  $disable               = params_lookup( 'disable' ),
  $disableboot           = params_lookup( 'disableboot' ),
  $monitor               = params_lookup( 'monitor' , 'global' ),
  $monitor_tool          = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target        = params_lookup( 'monitor_target' , 'global' ),
  $puppi                 = params_lookup( 'puppi' , 'global' ),
  $puppi_helper          = params_lookup( 'puppi_helper' , 'global' ),
  $firewall              = params_lookup( 'firewall' , 'global' ),
  $firewall_tool         = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src          = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst          = params_lookup( 'firewall_dst' , 'global' ),
  $debug                 = params_lookup( 'debug' , 'global' ),
  $audit_only            = params_lookup( 'audit_only' , 'global' ),
  $package               = params_lookup( 'package' ),
  $module_package_prefix = params_lookup( 'module_package_prefix' ),
  $module_package_suffix = params_lookup( 'module_package_suffix' ),
  $service               = params_lookup( 'service' ),
  $service_status        = params_lookup( 'service_status' ),
  $process               = params_lookup( 'process' ),
  $process_args          = params_lookup( 'process_args' ),
  $process_user          = params_lookup( 'process_user' ),
  $config_dir            = params_lookup( 'config_dir' ),
  $config_file           = params_lookup( 'config_file' ),
  $config_file_mode      = params_lookup( 'config_file_mode' ),
  $config_file_owner     = params_lookup( 'config_file_owner' ),
  $config_file_group     = params_lookup( 'config_file_group' ),
  $config_file_init      = params_lookup( 'config_file_init' ),
  $init_start_shellvar   = params_lookup( 'init_start_shellvar' ),
  $pid_file              = params_lookup( 'pid_file' ),
  $ctl_file              = params_lookup( 'ctl_file' ),
  $data_dir              = params_lookup( 'data_dir' ),
  $log_dir               = params_lookup( 'log_dir' ),
  $log_file              = params_lookup( 'log_file' ),
  $accesslog_file        = params_lookup( 'accesslog_file' ),
  $modules_dir           = params_lookup( 'modules_dir' ),
  $port                  = params_lookup( 'port' ),
  $protocol              = params_lookup( 'protocol' )
  ) inherits c_icap::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $c_icap::bool_absent ? {
    true  => 'absent',
    false => $c_icap::version,
  }

  $manage_service_enable = $c_icap::bool_disableboot ? {
    true    => false,
    default => $c_icap::bool_disable ? {
      true    => false,
      default => $c_icap::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $c_icap::bool_disable ? {
    true    => 'stopped',
    default =>  $c_icap::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $c_icap::bool_service_autorestart ? {
    true    => Service['c-icap'],
    false   => undef,
  }

  $manage_file = $c_icap::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $c_icap::bool_absent == true
  or $c_icap::bool_disable == true
  or $c_icap::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $c_icap::bool_absent == true
  or $c_icap::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $c_icap::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $c_icap::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $c_icap::source ? {
    ''        => undef,
    default   => $c_icap::source,
  }

  $manage_file_content = $c_icap::template ? {
    ''        => undef,
    default   => template($c_icap::template),
  }

  $should_start = $c_icap::bool_disable ? {
    true    => 'no',
    default =>  $c_icap::bool_absent ? {
      true    => undef,
      default => 'yes',
    },
  }

  ### Managed resources
  package { $c_icap::package:
    ensure  => $c_icap::manage_package,
  }

  if $config_file_init != undef and $should_start != undef {
    augeas {'c-icap::set_start':
      context => "/files/${c_icap::config_file_init}",
      changes => "set ${init_start_shellvar} ${should_start}",
      incl    => $c_icap::config_file_init,
      lens    => 'Shellvars.lns',
      require => Package[$c_icap::package],
      notify  => $c_icap::manage_service_autorestart,
    }
  }
  service { 'c-icap':
    ensure    => $c_icap::manage_service_ensure,
    name      => $c_icap::service,
    enable    => $c_icap::manage_service_enable,
    hasstatus => $c_icap::service_status,
    pattern   => $c_icap::process,
    require   => Package[$c_icap::package],
  }
  exec { 'c-icap_reconfigure':
    command     => "echo -n 'reconfigure' > ${c_icap::ctl_file}",
    provider    => 'shell',
    refreshonly => true,
  }

  file { 'c-icap.conf':
    ensure  => $c_icap::manage_file,
    path    => $c_icap::config_file,
    mode    => $c_icap::config_file_mode,
    owner   => $c_icap::config_file_owner,
    group   => $c_icap::config_file_group,
    require => Package[$c_icap::package],
    notify  => $c_icap::manage_service_autorestart,
    source  => $c_icap::manage_file_source,
    content => $c_icap::manage_file_content,
    replace => $c_icap::manage_file_replace,
    audit   => $c_icap::manage_audit,
  }

  # The whole c_icap configuration directory can be recursively overriden
  if $c_icap::source_dir and $c_icap::source_dir != '' {
    file { 'c-icap.dir':
      ensure  => directory,
      path    => $c_icap::config_dir,
      require => Package[$c_icap::package],
      notify  => $c_icap::manage_service_autorestart,
      source  => $c_icap::source_dir,
      recurse => true,
      purge   => $c_icap::bool_source_dir_purge,
      force   => $c_icap::bool_source_dir_purge,
      replace => $c_icap::manage_file_replace,
      audit   => $c_icap::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $c_icap::my_class and $c_icap::my_class != '' {
    include $c_icap::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $c_icap::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'c_icap':
      ensure    => $c_icap::manage_file,
      variables => $classvars,
      helper    => $c_icap::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $c_icap::bool_monitor == true {
    if $c_icap::port != '' {
      monitor::port { "c_icap_${c_icap::protocol}_${c_icap::port}":
        protocol => $c_icap::protocol,
        port     => $c_icap::port,
        target   => $c_icap::monitor_target,
        tool     => $c_icap::monitor_tool,
        enable   => $c_icap::manage_monitor,
      }
    }
    if $c_icap::service != '' {
      monitor::process { 'c_icap_process':
        process  => $c_icap::process,
        service  => $c_icap::service,
        pidfile  => $c_icap::pid_file,
        user     => $c_icap::process_user,
        argument => $c_icap::process_args,
        tool     => $c_icap::monitor_tool,
        enable   => $c_icap::manage_monitor,
      }
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $c_icap::bool_firewall == true and $c_icap::port != '' {
    firewall { "c_icap_${c_icap::protocol}_${c_icap::port}":
      source      => $c_icap::firewall_src,
      destination => $c_icap::firewall_dst,
      protocol    => $c_icap::protocol,
      port        => $c_icap::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $c_icap::firewall_tool,
      enable      => $c_icap::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $c_icap::bool_debug == true {
    file { 'debug_c_icap':
      ensure  => $c_icap::manage_file,
      path    => "${settings::vardir}/debug-c_icap",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}

# Puppet module: c_icap

This is a Puppet module for c-icap based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Mathieu Parent

Example42 site: http://www.example42.com

Official git repository: http://github.com/sathieu/puppet-c_icap

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* Install c-icap with default settings

        class { 'c_icap': }

* Install a specific version of c-icap package

        class { 'c_icap':
          version => '1.0.1',
        }

* Install two c-icap modules

        c_icap::module {
          'clamav':;
          'urlcheck':;
        }

* Disable c-icap service.

        class { 'c_icap':
          disable => true
        }

* Remove c-icap package

        class { 'c_icap':
          absent => true
        }

* Enable auditing without without making changes on existing c-icap configuration *files*

        class { 'c_icap':
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'c_icap':
          source => [ "puppet:///modules/example42/c_icap/c-icap.conf-${hostname}" , "puppet:///modules/example42/c_icap/c-icap.conf" ],
        }


* Use custom source directory for the whole configuration dir

        class { 'c_icap':
          source_dir       => 'puppet:///modules/example42/c_icap/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'c_icap':
          template => 'c_icap/c-icap.conf.erb',
        }

* Automatically include a custom subclass

        class { 'c_icap':
          my_class => 'example42::my_c_icap',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'c_icap':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'c_icap':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'c_icap':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'c_icap':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-c_icap.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-c_icap]

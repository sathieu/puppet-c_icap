# Class: c_icap::spec
#
# This class is used only for rpsec-puppet tests
# Can be taken as an example on how to do custom classes but should not
# be modified.
#
# == Usage
#
# This class is not intended to be used directly.
# Use it as reference
#
class c_icap::spec inherits c_icap {

  # This just a test to override the arguments of an existing resource
  # Note that you can achieve this same result with just:
  # class { "c_icap": template => "c_icap/spec.erb" }

  File['c-icap.conf'] {
    content => template('c_icap/spec.erb'),
  }

}

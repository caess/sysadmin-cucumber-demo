# Class: demo::editors
#
#
class demo::editors {
  # Editors on the VMs
  # vim (and vi) are already included in the base images so we don't need
  # to specify them here.

  package { 'emacs':
    ensure => installed,
  }

  package { 'nano':
    ensure => installed,
  }
}
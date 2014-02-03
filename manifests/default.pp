# User

## Update apt before installing any packages

exec { "apt-update":
  command => "/usr/bin/apt-get update"
}

Exec["apt-update"] -> Package <| |>

## Link bash profile

file { "/home/vagrant/.bash_profile":
  ensure => link,
  target => "/vagrant/.bash_profile"
}


# Development

package { "build-essential":
  ensure => latest
}

package { "tree":
  ensure => latest
}

package { "splint":
  ensure => latest
}

# Testing

class { "ruby":
  gems_version  => latest
}

package { "cucumber":
  ensure => latest,
  provider => "gem",
  require => Package[[rubygems]]
}

package { "rspec":
  ensure => latest,
  provider => "gem",
  require => Package[[rubygems]]
}

# Ops

package { "vim":
  ensure => latest
}

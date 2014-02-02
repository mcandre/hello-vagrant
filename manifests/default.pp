# User

exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

Exec["apt-update"] -> Package <| |>

file { "/home/vagrant/.bash_profile":
  ensure => link,
  target => "/vagrant/.bash_profile"
}


# Development

package { "build-essential":
  ensure => present
}

package { "tree":
  ensure => present
}

package { "splint":
  ensure => present
}

# Testing

class { "ruby":
  gems_version  => 'latest'
}

package { "cucumber":
  ensure => present,
  provider => "gem"
}

package { "rspec":
  ensure => present,
  provider => "gem"
}

package { "vim":
  ensure => present
}

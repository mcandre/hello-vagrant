# User

## Update apt before installing any packages

exec { 'apt-update':
    command => '/usr/bin/apt-get update'
}

Exec['apt-update'] -> Package <| |>

## Link bash profile

file { '/home/vagrant/.bash_profile':
    ensure => link,
    target => '/vagrant/.bash_profile'
}

# Development

package { ['build-essential', 'tree', 'splint']:
    ensure => latest
}

# Testing

package { 'rubygems':
    ensure => latest
}

package { 'bundler':
    ensure     => latest,
    provider => 'gem',
    require    => Package[[rubygems]]
}

exec { 'bundle':
    command     => '/usr/local/bin/bundle',
    cwd             => '/vagrant/',
    subscribe => Package[[bundler]]
}

# Ops

package { 'vim':
    ensure => latest
}

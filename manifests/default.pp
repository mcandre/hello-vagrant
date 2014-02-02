package { "build-essential":
  ensure => present
}

package { "tree":
  ensure => present
}

package { "splint":
  ensure => present
}

file { "/home/vagrant/.bash_profile":
  ensure => link,
  target => "/vagrant/.bash_profile"
}

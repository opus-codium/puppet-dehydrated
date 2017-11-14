class dehydrated::repo {
  include dehydrated

  vcsrepo { $dehydrated::etcdir:
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/lukas2511/dehydrated.git',
    revision => 'v0.4.0',
    user     => $dehydrated::user,
  }
}

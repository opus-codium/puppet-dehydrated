class dehydrated::repo {
  include ::dehydrated

  vcsrepo { $dehydrated::etcdir:
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/lukas2511/dehydrated.git',
    revision => 'v0.3.1',
    user     => $dehydrated::user,
  }
}

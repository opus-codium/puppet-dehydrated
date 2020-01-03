# @summary Manage the dehydrated code
class dehydrated::repo {
  include dehydrated

  vcsrepo { $dehydrated::etcdir:
    ensure   => present,
    provider => 'git',
    source   => $dehydrated::repo_source,
    revision => $dehydrated::repo_revision,
    user     => $dehydrated::user,
  }
}

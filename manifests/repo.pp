# @summary Manage the dehydrated code
#
# @api private
class dehydrated::repo {
  assert_private()

  vcsrepo { $dehydrated::etcdir:
    ensure   => present,
    provider => 'git',
    source   => $dehydrated::repo_source,
    revision => $dehydrated::repo_revision,
    user     => $dehydrated::user,
  }
}

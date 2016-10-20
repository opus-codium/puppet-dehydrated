class letsencrypt_sh::repo {
  include letsencrypt_sh

  vcsrepo { $letsencrypt_sh::etcdir:
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/lukas2511/dehydrated.git',
    revision => 'v0.3.1',
    user     => $letsencrypt_sh::user,
  }
}

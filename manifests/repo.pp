class letsencrypt_sh::repo {
  include letsencrypt_sh

  vcsrepo { $letsencrypt_sh::etcdir:
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/lukas2511/letsencrypt.sh.git',
    user     => $letsencrypt_sh::user,
  }
}

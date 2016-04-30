# puppet-letsencrypt_sh

## Usage

~~~
class { 'letsencrypt_sh':
  contact_email => 'user@example.com',
}

letsencrypt_sh::certificate { 'example.com':
  domains => [
    'foo.example.com',
    'bar.example.com',
  ],
}
~~~

## Cron integration

The `cron_integration` parameter can be set to `true` in order to renew certificates before they expire.

~~~
class { 'letsencrypt_sh':
  contact_email    => 'user@example.com',
  cron_integration => true,
}
~~~

## Apache integration

The module can configure apache to serve the generated challenges.  In such a situation, redirecting all HTTP requests to HTTPS except those releated to letsencrypt's validation can be achieved as in the following example:

~~~
class { 'letsencrypt_sh':
  contact_email      => 'user@example.com',
  apache_integration => true,
}

apache::vhost { 'main':
  port           => 80,
  default_vhost  => true,
  docroot        => '/var/empty',
  manage_docroot => false,
  directories    => [
    {
      path     => '/var/empty',
      rewrites => [
        {
          rewrite_rule => '.* https://%{HTTP_HOST}%{REQUEST_URI} [R=301]',
        },
      ],
    },
  ],
}
~~~

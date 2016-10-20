# letsencrypt\_sh

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
2. [Setup - The basics of getting started with letsencrypt\_sh](#setup)
    * [Beginning with letsencrypt\_sh](#beginning-with-letsencrypt_sh)
3. [Usage - Configuration options and additional functionality](#usage)
    * [Generate a simple certificate](#generate-a-simple-certificate)
    * [Generate a certificate with SAN](#generate-a-certificate-with-san)
    * [Renewing certificates with cron](#renewing-certificates-with-cron)
    * [Serving challenges with Apache](#serving-challenges-with-apache)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
    * [Defined Types](#defined-types)

## Module Description

The letsencrypt\_sh module lets you use Puppet to manage [Let's Encrypt](https://letsencrypt.org/) certificates creation and renewal.

## Setup

### Beginning with letsencrypt\_sh

Let's encrypt needs a contact address that must be passed to the `letsencrypt_sh` class:

```puppet
class { 'letsencrypt_sh':
  contact_email => 'user@example.com',
}
```

This is enough to get started and creating certificates.

## Usage

### Generate a simple certificate

After including the required `letsencrypt_sh` class, each `letsencrypt_sh::certificate` will produce a single certificate file:

```puppet
class { 'letsencrypt_sh':
  contact_email => 'user@example.com',
}

letsencrypt_sh::certificate { 'example.com':
}
```

### Generate a certificate with SAN

A `letsencrypt_sh::certificate` can use the `domain` parameter to indicate Subject Alternative Names (SAN).

```puppet
class { 'letsencrypt_sh':
  contact_email => 'user@example.com',
}

letsencrypt_sh::certificate { 'example.com':
  domains => [
    'www.example.com',
    'example.net',
    'www.example.net'
  ],
}
```

### Renewing certificates with cron

The `cron_integration` parameter of the `letsencrypt_sh` class configures cron to renew certificates before they expire.

```puppet
class { 'letsencrypt_sh':
  contact_email    => 'user@example.com',
  cron_integration => true,
}
```

### Serving challenges with Apache

The `apache_integration` parameter of the `letsencrypt_sh` class configures apache to serve the challenges used for domain validation.

The following example redirect all HTTP requests to HTTPS except those related to letsencrypt's validation:

```puppet
include ::apache

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
```

## Reference

### Classes

#### Public Classes

* [`letsencrypt_sh`](#class-letsencrypt_sh)

### Defined Types

* [`letsencrypt_sh::certificate`](#defined-type-letsencrypt_shcertificate)

#### Class: `letsencrypt_sh`

Main class used to setup the system.

##### Required parameters

* `contact_email`: The e-mail address Let's Encrypt can use to reach you regarding your certificates.

##### Optional parameters

* `apache_integration`: Specifies whether to setup apache to serve the generated challenges. Default: 'false'.
* `cron_integration`: Specifies whether to setup cron to automatically renew certificates. Default: 'false'.
* `user`: Specifies the user account used to manage certificates. Default: 'letsencrypt'.

#### Defined Type: `letsencrypt_sh::certificate`

Class used to describe the certificates that should be maintained.

##### Parameters (all optional)

* `domains`: Specifies the list of domains to include as SAN (Subject Alternative Names).

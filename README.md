# dehydrated

[![Build Status](https://travis-ci.org/opus-codium/puppet-dehydrated.svg?branch=master)](https://travis-ci.org/opus-codium/puppet-dehydrated)

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
2. [Setup - The basics of getting started with dehydrated](#setup)
    * [Beginning with dehydrated](#beginning-with-dehydrated)
3. [Usage - Configuration options and additional functionality](#usage)
    * [Generate a simple certificate](#generate-a-simple-certificate)
    * [Generate a certificate with SAN](#generate-a-certificate-with-san)
    * [Renewing certificates with cron](#renewing-certificates-with-cron)
    * [Serving challenges with Apache](#serving-challenges-with-apache)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
    * [Defined Types](#defined-types)

## Module Description

The dehydrated module lets you use Puppet to manage [Let's Encrypt](https://letsencrypt.org/) certificates creation and renewal using [dehydrated](https://github.com/lukas2511/dehydrated).

## Setup

### Beginning with dehydrated

Let's encrypt needs a contact address that must be passed to the `dehydrated` class:

```puppet
class { 'dehydrated':
  contact_email => 'user@example.com',
}
```

This is enough to get started and creating certificates.

## Usage

### Generate a simple certificate

After including the required `dehydrated` class, each `dehydrated::certificate` will produce a single certificate file:

```puppet
class { 'dehydrated':
  contact_email => 'user@example.com',
}

dehydrated::certificate { 'example.com':
}
```

### Generate a certificate with SAN

A `dehydrated::certificate` can use the `domains` parameter to indicate Subject Alternative Names (SAN).

```puppet
class { 'dehydrated':
  contact_email => 'user@example.com',
}

dehydrated::certificate { 'example.com':
  domains => [
    'www.example.com',
    'example.net',
    'www.example.net'
  ],
}
```

### Renewing certificates with cron

The `cron_integration` parameter of the `dehydrated` class configures cron to renew certificates before they expire.

```puppet
class { 'dehydrated':
  contact_email    => 'user@example.com',
  cron_integration => true,
}
```

**Please note that the web server is not automatically restarted when certificates are renewed.**

### Serving challenges with Apache

The `apache_integration` parameter of the `dehydrated` class configures apache to serve the challenges used for domain validation.

The following example redirect all HTTP requests to HTTPS except those related to letsencrypt's validation:

```puppet
include ::apache
include ::apache::mod::rewrite

class { 'dehydrated':
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

* [`dehydrated`](#class-dehydrated)

### Defined Types

* [`dehydrated::certificate`](#defined-type-dehydratedcertificate)

#### Class: `dehydrated`

Main class used to setup the system.

##### Required parameters

* `contact_email`: The e-mail address Let's Encrypt can use to reach you regarding your certificates.

##### Optional parameters

* `apache_integration`: Specifies whether to setup apache to serve the generated challenges. Default: 'false'.
* `cron_integration`: Specifies whether to setup cron to automatically renew certificates. Default: 'false'.
* `private_key_renew`: Regenerate private keys instead of just signing new certificates on renewal. Default: 'yes'.
* `user`: Specifies the user account used to manage certificates. Default: 'dehydrated'.

#### Defined Type: `dehydrated::certificate`

Class used to describe the certificates that should be maintained.

##### Parameters (all optional)

* `domains`: Specifies the list of domains to include as SAN (Subject Alternative Names).

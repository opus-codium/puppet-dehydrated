# dehydrated

[![Build Status](https://travis-ci.com/opus-codium/puppet-dehydrated.svg?branch=master)](https://travis-ci.com/opus-codium/puppet-dehydrated)

#### Table of Contents

<!-- vim-markdown-toc GFM -->

* [Module Description](#module-description)
* [Setup](#setup)
  * [Beginning with dehydrated](#beginning-with-dehydrated)
* [Usage](#usage)
  * [Generate a simple certificate](#generate-a-simple-certificate)
  * [Generate a certificate with SAN](#generate-a-certificate-with-san)
  * [Use DNS-01 hook](#use-dns-01-hook)
  * [Renewing certificates with cron](#renewing-certificates-with-cron)
  * [Serving challenges with Apache](#serving-challenges-with-apache)
* [Reference](#reference)
  * [Classes](#classes)
    * [Public Classes](#public-classes)
    * [Class: `dehydrated`](#class-dehydrated)
      * [Required parameters](#required-parameters)
      * [Optional parameters](#optional-parameters)
  * [Defined Types](#defined-types)
    * [Defined Type: `dehydrated::certificate`](#defined-type-dehydratedcertificate)
      * [Parameters (all optional)](#parameters-all-optional)

<!-- vim-markdown-toc -->

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

### Use DNS-01 hook

Examples of dns-01 `hook.sh`:
* [nsupdate](https://github.com/lukas2511/dehydrated/blob/master/docs/examples/hook.sh)
* [more](https://github.com/lukas2511/dehydrated/wiki/Examples-for-DNS-01-hooks)

**Hook must wait until DNS records are really synced across public DNS servers and only
then finish. Otherwise Let's Encrypt won't find the records from their side and dehydrated
run will fail.**

```puppet
class { 'dehydrated':
  contact_email => 'user@example.com',
  challengetype => 'dns-01',
  hook          => '/home/dehydrated/hook.sh',
  timeout       => 600,
}

dehydrated::certificate { 'example.com':
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

#### Class: `dehydrated`

Main class used to setup the system.

##### Required parameters

* `contact_email`: The e-mail address Let's Encrypt can use to reach you regarding your certificates.

##### Optional parameters

* `apache_integration`: Specifies whether to setup apache to serve the generated challenges. Default: 'false'.
* `cron_integration`: Specifies whether to setup cron to automatically renew certificates. Default: 'false'.
* `user`: Specifies the user account used to manage certificates. Default: 'dehydrated'.

* `ipversion`: Resolve names to addresses of IP version only.
* `ca`: Path to certificate authority.
* `ca_terms`: Path to certificate authority license terms redirect.
* `license`: Path to license agreement.
* `challengetype`: Which challenge should be used?
* `keysize`: Default keysize for private keys.
* `openssl_cnf`: Path to openssl config file.
* `hook`: Program or function called in certain situations.
* `hook_chain`: Chain clean_challenge|deploy_challenge arguments together into one hook call per certificate.
* `renew_days`: Minimum days before expiration to automatically renew certificate.
* `private_key_renew`: Regenerate private keys instead of just signing new certificates on renewal.
* `private_key_rollover`: Create an extra private key for rollover.
* `key_algo`: Which public key algorithm should be used?
* `ocsp_must_staple`: Option to add CSR-flag indicating OCSP stapling to be mandatory.
* `timeout`: Execution timeout for dehydrated tool. Default: '300'.

### Defined Types

#### Defined Type: `dehydrated::certificate`

Class used to describe the certificates that should be maintained.

##### Parameters (all optional)

* `domains`: Specifies the list of domains to include as SAN (Subject Alternative Names).

### Functions

#### Function: `dehydrated::ssl_cert_file`

Function used to provide the `ssl_cert_file` path.

##### Required parameters

* `hostname`: Hostname

#### Function: `dehydrated::ssl_privkey_file`

Function used to provide the `ssl_privkey_file` path.

##### Required parameters

* `hostname`: Hostname

#### Function: `dehydrated::ssl_chain_file`

Function used to provide the `ssl_chain_file` path.

##### Required parameters

* `hostname`: Hostname

#### Function: `dehydrated::ssl_fullchain_file`

Function used to provide the `ssl_fullchain_file` path.

##### Required parameters

* `hostname`: Hostname

#### Function: `dehydrated::apache::vhost_attributes`

Function used to provide the SSL attributes for `apache::vhost` defined type.
It returns a hash with `ssl_cert`, `ssl_key` and `ssl_chain` keys.

This function is designed to be used as hash attributes using splat operator, ie.:

```puppet
apache::vhost { $hostname:
  port => 443,
  ssl  => true,
  [...]
  *    => dehydrated::apache::vhost_attributes($hostname)
}
```

##### Required parameters

* `hostname`: Hostname

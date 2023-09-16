# dehydrated

<!-- header GFM -->
[![Build Status](https://img.shields.io/github/actions/workflow/status/opus-codium/puppet-dehydrated/release.yml)](https://github.com/opus-codium/puppet-dehydrated/releases)
[![Puppet Forge](https://img.shields.io/puppetforge/v/opuscodium/dehydrated.svg)](https://forge.puppetlabs.com/opuscodium/dehydrated)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/opuscodium/dehydrated.svg)](https://forge.puppetlabs.com/opuscodium/dehydrated)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/opuscodium/dehydrated.svg)](https://forge.puppetlabs.com/opuscodium/dehydrated)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/opuscodium/dehydrated.svg)](https://forge.puppetlabs.com/opuscodium/dehydrated)
[![License](https://img.shields.io/github/license/opus-codium/puppet-dehydrated.svg)](https://github.com/voxpupuli/opuscodium-dehydrated/blob/master/LICENSE.md)
<!-- header -->

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

<!-- vim-markdown-toc -->

## Module Description

The dehydrated module lets you use Puppet to manage [Let's Encrypt](https://letsencrypt.org/) certificates creation and renewal using [dehydrated](https://github.com/dehydrated-io/dehydrated).

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

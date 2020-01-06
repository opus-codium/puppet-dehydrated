# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- Keep going on certificate failure.

## [2.2.0]
### Added
- Support for RedHat based operating systems.

## [2.1.0]
### Added
- Added missing dependency on `apache::mod::alias`,
- Allow end-user to customize dehydrated source when using a repo (`$dehydrated::repo_source`),
- Allow end-user to customize dehydrated version when using a repo (`$dehydrated::repo_revision`),
- Allow end-user to customize execution timeout (`$dehydrated::timeout`).

### Changed
- Default to the latests dehydrated release (v0.5.0) when using a repo.

## [2.0.0]
### Added
- `$dehydrated::ipversion` parameter,
- `$dehydrated::ca` parameter,
- `$dehydrated::ca_terms` parameter,
- `$dehydrated::license` parameter,
- `$dehydrated::challengetype` parameter,
- `$dehydrated::keysize` parameter,
- `$dehydrated::openssl_cnf` parameter,
- `$dehydrated::hook` parameter,
- `$dehydrated::hook_chain` parameter,
- `$dehydrated::renew_days` parameter,
- `$dehydrated::private_key_renew` parameter,
- `$dehydrated::private_key_rollover` parameter,
- `$dehydrated::key_algo` parameter,
- `$dehydrated::ocsp_must_staple` parameter.

### Changed
- Modernize code base,
- Install curl on Debian hosts.

### Removed
- letsencrypt.sh to dehydrated migration support.

## [1.1.0] - 2017-07-21
### Changed
- Install dehydrated 0.4.0 on Debian.

## [1.0.1] - 2017-01-08
### Fixed
- Fix warning when `strict_variable` checking is set.

## [1.0.0] - 2017-01-08
### Initial release

[Unreleased]: https://github.com/opus-codium/puppet-dehydrated/compare/2.2.0...master
[2.2.0]: https://github.com/opus-codium/puppet-dehydrated/compare/2.1.0...2.2.0
[2.1.0]: https://github.com/opus-codium/puppet-dehydrated/compare/2.0.0...2.1.0
[2.0.0]: https://github.com/opus-codium/puppet-dehydrated/compare/1.1.0...2.0.0
[1.1.0]: https://github.com/opus-codium/puppet-dehydrated/compare/1.0.1...1.1.0
[1.0.1]: https://github.com/opus-codium/puppet-dehydrated/compare/1.0.0...1.0.1

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [5.0.0](https://github.com/opus-codium/puppet-dehydrated/tree/5.0.0) (2022-09-10)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/4.1.1...5.0.0)

**Breaking changes:**

- Drop support of Debian 8 \(EOL\) [\#48](https://github.com/opus-codium/puppet-dehydrated/pull/48) ([smortex](https://github.com/smortex))

**Implemented enhancements:**

- Add support for Debian 11 [\#47](https://github.com/opus-codium/puppet-dehydrated/pull/47) ([smortex](https://github.com/smortex))

**Merged pull requests:**

- Tag private classes @api private [\#50](https://github.com/opus-codium/puppet-dehydrated/pull/50) ([smortex](https://github.com/smortex))
- Allow stdlib 8.x [\#49](https://github.com/opus-codium/puppet-dehydrated/pull/49) ([smortex](https://github.com/smortex))

## [4.1.1](https://github.com/opus-codium/puppet-dehydrated/tree/4.1.1) (2021-05-14)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/4.1.0...4.1.1)

**Fixed bugs:**

- Fix CHANGELOG.md [\#45](https://github.com/opus-codium/puppet-dehydrated/pull/45) ([smortex](https://github.com/smortex))

## [4.1.0](https://github.com/opus-codium/puppet-dehydrated/tree/4.1.0) (2021-05-14)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/4.0.0...4.1.0)

**Implemented enhancements:**

- Add support for --noop to dehydrated::cleanup [\#42](https://github.com/opus-codium/puppet-dehydrated/pull/42) ([smortex](https://github.com/smortex))

## [4.0.0](https://github.com/opus-codium/puppet-dehydrated/tree/4.0.0) (2021-05-10)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/3.1.0...4.0.0)

**Breaking changes:**

- Remove Puppet 5 from testing and bump minimal version to 6.0.0 [\#40](https://github.com/opus-codium/puppet-dehydrated/pull/40) ([smortex](https://github.com/smortex))

**Implemented enhancements:**

- Add a cleanup task to remove unmanaged certificates [\#41](https://github.com/opus-codium/puppet-dehydrated/pull/41) ([smortex](https://github.com/smortex))

## [3.1.0](https://github.com/opus-codium/puppet-dehydrated/tree/3.1.0) (2021-04-14)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/3.0.0...3.1.0)

**Implemented enhancements:**

- Update dependencies [\#39](https://github.com/opus-codium/puppet-dehydrated/pull/39) ([smortex](https://github.com/smortex))
- Add REFERENCE.md [\#32](https://github.com/opus-codium/puppet-dehydrated/pull/32) ([neomilium](https://github.com/neomilium))

**Fixed bugs:**

- Remove explicit data\_provider from metadata.json [\#35](https://github.com/opus-codium/puppet-dehydrated/pull/35) ([smortex](https://github.com/smortex))

## [3.0.0](https://github.com/opus-codium/puppet-dehydrated/tree/3.0.0) (2020-12-26)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/2.4.1...3.0.0)

**Breaking changes:**

- Update the dehydrated repository URL [\#30](https://github.com/opus-codium/puppet-dehydrated/pull/30) ([smortex](https://github.com/smortex))

## [2.4.1](https://github.com/opus-codium/puppet-dehydrated/tree/2.4.1) (2020-12-25)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/2.4.0...2.4.1)

**Fixed bugs:**

- Restore the previous dehydrated repository URL [\#28](https://github.com/opus-codium/puppet-dehydrated/pull/28) ([smortex](https://github.com/smortex))

## [2.4.0](https://github.com/opus-codium/puppet-dehydrated/tree/2.4.0) (2020-12-21)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/2.3.0...2.4.0)

**Implemented enhancements:**

- Default to dehydrated 0.7.0 when installing from repos [\#26](https://github.com/opus-codium/puppet-dehydrated/pull/26) ([smortex](https://github.com/smortex))
- Move common default values to init.pp [\#25](https://github.com/opus-codium/puppet-dehydrated/pull/25) ([smortex](https://github.com/smortex))

## [2.3.0](https://github.com/opus-codium/puppet-dehydrated/tree/2.3.0) (2020-09-04)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/2.2.0...2.3.0)

**Implemented enhancements:**

- Implement helper functions to retrieve ssl paths [\#21](https://github.com/opus-codium/puppet-dehydrated/pull/21) ([neomilium](https://github.com/neomilium))
- Make internal classes private [\#20](https://github.com/opus-codium/puppet-dehydrated/pull/20) ([smortex](https://github.com/smortex))
- Add task and plan to renew certificates [\#16](https://github.com/opus-codium/puppet-dehydrated/pull/16) ([smortex](https://github.com/smortex))
- Keep going on certificate creation/renewal failure [\#14](https://github.com/opus-codium/puppet-dehydrated/pull/14) ([smortex](https://github.com/smortex))
- Add documentation for classes and defined types [\#13](https://github.com/opus-codium/puppet-dehydrated/pull/13) ([smortex](https://github.com/smortex))

## [2.2.0](https://github.com/opus-codium/puppet-dehydrated/tree/2.2.0) (2019-05-07)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/2.1.0...2.2.0)

## [2.1.0](https://github.com/opus-codium/puppet-dehydrated/tree/2.1.0) (2018-12-05)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/2.0.0...2.1.0)

**Implemented enhancements:**

- Add support for exec timeout option [\#9](https://github.com/opus-codium/puppet-dehydrated/pull/9) ([sergiik](https://github.com/sergiik))
- Default to dehydrated 0.5.0 when installing from repos [\#5](https://github.com/opus-codium/puppet-dehydrated/pull/5) ([smortex](https://github.com/smortex))

**Fixed bugs:**

- Add missing dependency on `apache::mod::alias` [\#6](https://github.com/opus-codium/puppet-dehydrated/pull/6) ([smortex](https://github.com/smortex))

## [2.0.0](https://github.com/opus-codium/puppet-dehydrated/tree/2.0.0) (2017-12-22)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/1.1.0...2.0.0)

**Implemented enhancements:**

- Allow expressing dependencies [\#3](https://github.com/opus-codium/puppet-dehydrated/pull/3) ([smortex](https://github.com/smortex))
- Extend and modernize puppet-dehydrated [\#2](https://github.com/opus-codium/puppet-dehydrated/pull/2) ([smortex](https://github.com/smortex))

## [1.1.0](https://github.com/opus-codium/puppet-dehydrated/tree/1.1.0) (2017-06-01)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/1.0.1...1.1.0)

**Implemented enhancements:**

- Update dehydrated to 0.4.0 [\#1](https://github.com/opus-codium/puppet-dehydrated/pull/1) ([neomilium](https://github.com/neomilium))

## [1.0.1](https://github.com/opus-codium/puppet-dehydrated/tree/1.0.1) (2017-01-08)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/1.0.0...1.0.1)

## [1.0.0](https://github.com/opus-codium/puppet-dehydrated/tree/1.0.0) (2016-10-20)

[Full Changelog](https://github.com/opus-codium/puppet-dehydrated/compare/4e5a5c199173891b0129eaa770343b586fd54574...1.0.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*

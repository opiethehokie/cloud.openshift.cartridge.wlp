# Change Log
All notable changes to this project will be documented in this file.

## [Unreleased][unreleased]

## [0.0.4][2015-02-20]
### Added
- Ability to git push an expanded WAR file or server package ZIP file

### Removed
- Ability to git push a WAR file or server package ZIP file

## [0.0.3][2015-02-11]
### Added
- Install New Relic agent when NEWRELIC_LICENSE environment variable is set.
- Cartridge install/uninstall instructions to README.
- Install JRebel agent when app contains rebel-remote.xml file.

### Changed
- README edits to make sure documentation is up-to-date.

### Removed
- Cartridge override of buildpack disabling 2PC in Liberty because OpenShift's auto-scaling would still cause in-doubt transaction recovery problems.

### Fixed
- Restage instead of restart when JVM environment variable changes.

[buildpack changelog]: https://github.com/cloudfoundry/ibm-websphere-liberty-buildpack

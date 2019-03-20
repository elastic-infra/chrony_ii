name 'chrony_ii'
maintainer 'Tomoya Kabe'
maintainer_email 'kabe@elastic-infra.com'
license 'MIT'
description 'Installs/Configures chrony_ii'
long_description 'Installs/Configures chrony_ii'
version '0.2.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

issues_url 'https://github.com/elastic-infra/chrony_ii/issues'
source_url 'https://github.com/elastic-infra/chrony_ii'

supports 'debian', '>= 8.0.0'
supports 'ubuntu', '>= 14.04.0'
supports 'centos', '>= 6.0.0'
supports 'redhat', '>= 0.0.0'
supports 'amazon', '>= 0.0.0'

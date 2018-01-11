name 'chrony_ii'
maintainer 'Tomoya Kabe'
maintainer_email 'kabe@elastic-infra.com'
license 'MIT'
description 'Installs/Configures chrony_ii'
long_description 'Installs/Configures chrony_ii'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

issues_url 'https://github.com/elastic-infra/chrony_ii/issues'
source_url 'https://github.com/elastic-infra/chrony_ii'

%w[redhat centos debian ubuntu amazon].each do |os|
  supports os
end

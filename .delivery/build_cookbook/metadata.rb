name 'build_cookbook'
maintainer 'Tomoya Kabe'
maintainer_email 'kabe@elastic-infra.com'
license 'mit'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'delivery-truck'

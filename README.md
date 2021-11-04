# Description

[![Build Status](https://travis-ci.org/elastic-infra/chrony_ii.svg?branch=master)](https://travis-ci.org/elastic-infra/chrony_ii) [![GitHub license](https://img.shields.io/github/license/elastic-infra/chrony_ii.svg)](https://github.com/elastic-infra/chrony_ii/blob/master/LICENSE) [![GitHub issues](https://img.shields.io/github/issues/elastic-infra/chrony_ii.svg)](https://github.com/elastic-infra/chrony_ii/issues) [![Cookbook Version](https://img.shields.io/cookbook/v/chrony_ii.svg)](https://supermarket.chef.io/cookbooks/chrony_ii)

Installs/Configures chrony

# Requirements


## Chef Client:

* chef (>= 12.1)

## Platform:

* debian (>= 8.0.0)
* ubuntu (>= 16.04.0)
* centos (>= 7.0.0)
* redhat
* amazon

## Cookbooks:

*No dependencies defined*

# Attributes

* `node[cookbook_name]['config']` - chrony.conf value. Hash value can be a string or an array of string. Defaults to `case node['platform_family']`.
* `node[cookbook_name]['amazon_time_sync_service']` - Whether to use [Amazon Time Sync Service](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html#configure-amazon-time-service). Defaults to `false`.
* `node[cookbook_name]['config_update_restart']` - Whether to restart chrony daemon after config file change. Defaults to `true`.

# Recipes

* [chrony_ii::config](#chrony_iiconfig) - Configures application name, path, and configuration file based on platform family.
* [chrony_ii::default](#chrony_iidefault) - Loads necessary recipes.
* [chrony_ii::package](#chrony_iipackage) - Removes competing packages and installs chrony.
* [chrony_ii::service](#chrony_iiservice) - Configures chrony service.
* [chrony_ii::systemd_support](#chrony_iisystemd_support)

## chrony_ii::config

Configures application name, path, and configuration file based on platform family.

## chrony_ii::default

Loads necessary recipes.

## chrony_ii::package

Removes competing packages and installs chrony.

## chrony_ii::service

Configures chrony service.

## chrony_ii::systemd_support

Provides supporting resources for systemd

# Resources

* [chrony_ii_systemd_dependency](#chrony_ii_systemd_dependency)

## chrony_ii_systemd_dependency

Manages additional chronyd service dependencies in systemd

### Actions

- create: Create chronyd service dependencies in systemd Default action.
- delete: Delete chronyd service dependencies in systemd

### Attribute Parameters

- systemd_system_dir: systemd's system config directory path
- wants: systemd service 'Wants=' targets with symlinks to 'chronyd.service.wants' Defaults to <code>"network-online.target"</code>.
- after: systemd service 'After=' targets with symlinks to 'chronyd.service.after' Defaults to <code>"network-online.target"</code>.

### Examples

```ruby
include_recipe 'chrony_ii::systemd_support'
chrony_ii_systemd_dependency '/usr/lib/systemd/system'
```

```ruby
include_recipe 'chrony_ii::systemd_support'
chrony_ii_systemd_dependency '/usr/lib/systemd/system' do
  wants 'x.target y.target'
  after 'x.target'
end
```

# Deprecation Notice

We are planning to migrate from attribute and recipe-based cookbook to custom resource-based cookbook.
Most recipes will be deprecated after providing custom resources.

For custom resource's `unified_mode` feature mandatory for Chef 17, the next major update requires Chef >= 15.3.0.


# Usage

If you are fine with using the public NTP servers you can simply include `chrony_ii` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chrony_ii]"
  ]
}
```

If you need to control your configuration use a role.


# License and Maintainer

Maintainer:: Tomoya Kabe (<kabe@elastic-infra.com>)

Source:: https://github.com/elastic-infra/chrony_ii

Issues:: https://github.com/elastic-infra/chrony_ii/issues

License:: MIT

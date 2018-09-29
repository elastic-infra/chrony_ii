chrony_ii cookbook
==================

[![Build Status](https://travis-ci.org/elastic-infra/chrony_ii.svg?branch=master)](https://travis-ci.org/elastic-infra/chrony_ii) [![GitHub license](https://img.shields.io/github/license/elastic-infra/chrony_ii.svg)](https://github.com/elastic-infra/chrony_ii/blob/master/LICENSE) [![GitHub issues](https://img.shields.io/github/issues/elastic-infra/chrony_ii.svg)](https://github.com/elastic-infra/chrony_ii/issues)

This cookbook installs chrony.

Requirements
------------

#### platforms
- debian >= 8
  - debian 7 should work but the installed version (v1.24) is too old to run on Linux 4.x (for CI)
- ubuntu >= 16.04
- centos >= 6
- redhat
- amazon

Attributes
----------

| Key | Type | Description | default |
| --- | --- | --- | --- |
|['chrony_ii']['config']|Hash|chrony.conf value. Hash value can be a string or an array of string.| Depends on platform (see `attributes/default.rb`) Default attributes use public NTP servers.|
| ['chrony_ii']['amazon_time_sync_service'] | Boolean | Whether to use <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html#configure-amazon-time-service">Amazon Time Sync Service</a> | false |
| ['chrony_ii']['config_update_restart']| Boolean | Whether to restart chrony daemon after config file change | true |



Recipes
---------
- default - executes the below three recipes.
- config - configures application name, path, and configuration file based on platform family.
- package - removes competing packages and installs chrony.
- service - configures chrony service.

Usage
-----
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

##### Sample attribute set for chrony.conf

```ruby
debian_attr = {
  'server' => [
    '0.debian.pool.ntp.org offline minpoll 8',
    '1.debian.pool.ntp.org offline minpoll 8',
    '2.debian.pool.ntp.org offline minpoll 8',
    '3.debian.pool.ntp.org offline minpoll 8'
  ],
  'keyfile' => '/etc/chrony/chrony.keys',
  'commandkey' => '1',
  'driftfile' => '/var/lib/chrony/chrony.drift',
  'log' => 'tracking measurements statistics',
  'logdir' => '/var/log/chrony',
  'maxupdateskew' => '100.0',
  'dumponexit' => '',
  'dumpdir' => '/var/lib/chrony',
  'local' => 'stratum 10',
  'allow' => [
    '10/8',
    '192.168/16',
    '172.16/12'
  ],
  'logchange' => '0.5',
  'rtconutc' => ''
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Tomoya Kabe

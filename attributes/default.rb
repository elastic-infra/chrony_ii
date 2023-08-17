# frozen_string_literal: true

debian_attr = {
  'pool' => [
    '0.debian.pool.ntp.org iburst',
    '1.debian.pool.ntp.org iburst',
    '2.debian.pool.ntp.org iburst',
    '3.debian.pool.ntp.org iburst',
  ],
  'initstepslew' => '30 0.debian.pool.ntp.org 1.debian.pool.ntp.org',
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
    '172.16/12',
  ],
  'logchange' => '0.5',
  'rtconutc' => '',
}

redhat_attr = {
  'pool' => [
    '0.centos.pool.ntp.org iburst',
    '1.centos.pool.ntp.org iburst',
    '2.centos.pool.ntp.org iburst',
    '3.centos.pool.ntp.org iburst',
  ],
  'initstepslew' => '30 0.centos.pool.ntp.org 1.centos.pool.ntp.org',
  'stratumweight' => '0',
  'driftfile' => '/var/lib/chrony/drift',
  'rtcsync' => '',
  'makestep' => '10 3',
  'bindcmdaddress' => [
    '127.0.0.1',
    '::1',
  ],
  'keyfile' => '/etc/chrony.keys',
  'commandkey' => '1',
  'generatecommandkey' => '',
  'noclientlog' => '',
  'logchange' => '0.5',
  'logdir' => '/var/log/chrony',
}

centos_9_attrs = {
  'pool' => [
    '0.amazon.pool.ntp.org iburst',
    '1.amazon.pool.ntp.org iburst',
    '2.amazon.pool.ntp.org iburst',
    '3.amazon.pool.ntp.org iburst',
  ],
  'initstepslew' => '30 0.amazon.pool.ntp.org 1.amazon.pool.ntp.org',
  'stratumweight' => '0',
  'driftfile' => '/var/lib/chrony/drift',
  'rtcsync' => '',
  'makestep' => '1.0 3',
  'bindcmdaddress' => [
    '127.0.0.1',
    '::1',
  ],
  'keyfile' => '/etc/chrony.keys',
  'noclientlog' => '',
  'logchange' => '0.5',
  'log' => 'measurements statistics tracking',
  'sourcedir' => '/run/chrony.d /etc/chrony.d',
  'logdir' => '/var/log/chrony',
  'confdir' => '/etc/chrony.d',
  'ntsdumpdir' => '/var/lib/chrony',
}

amazon_attr = {
  'pool' => [
    '0.amazon.pool.ntp.org iburst',
    '1.amazon.pool.ntp.org iburst',
    '2.amazon.pool.ntp.org iburst',
    '3.amazon.pool.ntp.org iburst',
  ],
  'initstepslew' => '30 0.amazon.pool.ntp.org 1.amazon.pool.ntp.org',
  'stratumweight' => '0',
  'driftfile' => '/var/lib/chrony/drift',
  'rtcsync' => '',
  'makestep' => '10 3',
  'bindcmdaddress' => [
    '127.0.0.1',
    '::1',
  ],
  'keyfile' => '/etc/chrony.keys',
  'commandkey' => '1',
  'generatecommandkey' => '',
  'noclientlog' => '',
  'logchange' => '0.5',
  'logdir' => '/var/log/chrony',
}

amazon_2023_attrs = {
  'pool' => [
    '0.amazon.pool.ntp.org iburst',
    '1.amazon.pool.ntp.org iburst',
    '2.amazon.pool.ntp.org iburst',
    '3.amazon.pool.ntp.org iburst',
  ],
  'initstepslew' => '30 0.amazon.pool.ntp.org 1.amazon.pool.ntp.org',
  'stratumweight' => '0',
  'driftfile' => '/var/lib/chrony/drift',
  'rtcsync' => '',
  'makestep' => '10 3',
  'bindcmdaddress' => [
    '127.0.0.1',
    '::1',
  ],
  'keyfile' => '/etc/chrony.keys',
  'noclientlog' => '',
  'logchange' => '0.5',
  'log' => 'measurements statistics tracking',
  'sourcedir' => '/run/chrony.d /etc/chrony.d',
  'logdir' => '/var/log/chrony',
  'confdir' => '/etc/chrony.d',
  'ntsdumpdir' => '/var/lib/chrony',
}

# Not in recipe yet
cookbook_name = 'chrony_ii'

# <> chrony.conf value. Hash value can be a string or an array of string.
default[cookbook_name]['config'] = case node['platform_family']
                                   when 'debian'
                                     debian_attr
                                   when 'rhel'
                                     (centos? && node['platform_version'].to_f >= 9) ? centos_9_attrs : redhat_attr
                                   when 'amazon'
                                     node['platform_version'].to_f >= 2023 ? amazon_2023_attrs : amazon_attr
                                   end

# <> Whether to use [Amazon Time Sync Service](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html#configure-amazon-time-service).
default[cookbook_name]['amazon_time_sync_service'] = false

# <> Whether to restart chrony daemon after config file change
default[cookbook_name]['config_update_restart'] = true

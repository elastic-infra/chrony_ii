debian_attr = {
  'pool' => [
    '0.debian.pool.ntp.org iburst',
    '1.debian.pool.ntp.org iburst',
    '2.debian.pool.ntp.org iburst',
    '3.debian.pool.ntp.org iburst'
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
    '172.16/12'
  ],
  'logchange' => '0.5',
  'rtconutc' => ''
}

redhat_attr = {
  'pool' => [
    '0.centos.pool.ntp.org iburst',
    '1.centos.pool.ntp.org iburst',
    '2.centos.pool.ntp.org iburst',
    '3.centos.pool.ntp.org iburst'
  ],
  'initstepslew' => '30 0.centos.pool.ntp.org 1.centos.pool.ntp.org',
  'stratumweight' => '0',
  'driftfile' => '/var/lib/chrony/drift',
  'rtcsync' => '',
  'makestep' => '10 3',
  'bindcmdaddress' => [
    '127.0.0.1',
    '::1'
  ],
  'keyfile' => '/etc/chrony.keys',
  'commandkey' => '1',
  'generatecommandkey' => '',
  'noclientlog' => '',
  'logchange' => '0.5',
  'logdir' => '/var/log/chrony'
}

amazon_attr = {
  'server' => '169.254.169.123 prefer iburst',
  'pool' => [
    '0.amazon.pool.ntp.org iburst',
    '1.amazon.pool.ntp.org iburst',
    '2.amazon.pool.ntp.org iburst',
    '3.amazon.pool.ntp.org iburst'
  ],
  'initstepslew' => '30 169.254.169.123 0.amazon.pool.ntp.org',
  'stratumweight' => '0',
  'driftfile' => '/var/lib/chrony/drift',
  'rtcsync' => '',
  'makestep' => '10 3',
  'bindcmdaddress' => [
    '127.0.0.1',
    '::1'
  ],
  'keyfile' => '/etc/chrony.keys',
  'commandkey' => '1',
  'generatecommandkey' => '',
  'noclientlog' => '',
  'logchange' => '0.5',
  'logdir' => '/var/log/chrony'
}

# Not in recipe yet
cookbook_name = 'chrony_ii'

default[cookbook_name]['config'] = case node['platform_family']
                                   when 'debian'
                                     debian_attr
                                   when 'rhel'
                                     redhat_attr
                                   when 'amazon'
                                     amazon_attr
                                   end

default[cookbook_name]['amazon_time_sync_service'] = false

default[cookbook_name]['config_update_restart'] = true

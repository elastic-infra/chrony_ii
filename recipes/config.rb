# frozen_string_literal: true

#
# Cookbook:: chrony_ii
# Recipe:: config
#
# The MIT License (MIT)
#
# Copyright:: 2018, Tomoya Kabe
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# <
# Configures application name, path, and configuration file based on platform family.
# >

config_path = value_for_platform_family(
  'rhel' => '/etc/chrony.conf',
  'amazon' => '/etc/chrony.conf',
  'debian' => '/etc/chrony/chrony.conf'
)

if node[cookbook_name]['amazon_time_sync_service']
  node.default[cookbook_name]['config']['server'] = [
    '169.254.169.123 iburst',
  ]
  node.default[cookbook_name]['config']['initstepslew'] = ['30 169.254.169.123']
  node.default[cookbook_name]['config']['pool'] = []
end

# Supports 'pool' directive? (chrony >= 2.0)
supports_pool = true
platform?('ubuntu') && node['platform_version'].to_f < 16 && supports_pool = false

config = node[cookbook_name]['config'].to_h.map do |k, v|
  k = 'server' if k == 'pool' && !supports_pool
  next if v == []

  case v
  when Array
    v.map { |vv| [k, vv].join(' ') }.join("\n")
  else
    [k, v].join(' ')
  end
end.join("\n")

restart = node[cookbook_name]['config_update_restart']

template config_path do
  source 'chrony.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[chrony-daemon]' if restart
  variables config_content: config
end

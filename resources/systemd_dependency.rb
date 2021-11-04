# frozen_string_literal: true

# <
# Manages additional chronyd service dependencies in systemd
#
# @action create Create chronyd service dependencies in systemd
# @action delete Delete chronyd service dependencies in systemd
#
# @section Examples
#
# ```ruby
# include_recipe 'chrony_ii::systemd_support'
# chrony_ii_systemd_dependency '/usr/lib/systemd/system'
# ```
#
# ```ruby
# include_recipe 'chrony_ii::systemd_support'
# chrony_ii_systemd_dependency '/usr/lib/systemd/system' do
#   wants 'x.target y.target'
#   after 'x.target'
# end
# ```
# >

unified_mode true

# <> @property systemd_system_dir systemd's system config directory path
property :systemd_system_dir, String, name_property: true

# <> @property wants systemd service 'Wants=' targets with symlinks to 'chronyd.service.wants'
property :wants, String, default: 'network-online.target'
# <> @property after systemd service 'After=' targets with symlinks to 'chronyd.service.after'
property :after, String, default: 'network-online.target'

action :create do
  if new_resource.wants != ''
    directory "#{new_resource.systemd_system_dir}/chronyd.service.wants"

    new_resource.wants.split(/ /).each do |target|
      link "#{new_resource.systemd_system_dir}/chronyd.service.wants/#{target}" do
        link_type :symbolic
        to "#{new_resource.systemd_system_dir}/#{target}"

        notifies :run, 'execute[chronyd-systemd-daemon-reload]', :delayed
      end
    end
  end

  if new_resource.after != ''
    directory "#{new_resource.systemd_system_dir}/chronyd.service.d"

    file "#{new_resource.systemd_system_dir}/chronyd.service.d/9999_after.conf" do
      content <<~EOCONTENT
      [Unit]
      After=#{new_resource.after}
      EOCONTENT

      notifies :run, 'execute[chronyd-systemd-daemon-reload]', :delayed
    end
  end
end

action :delete do
  directory "#{new_resource.systemd_system_dir}/chronyd.service.wants" do
    recursive true
    action :delete

    notifies :run, 'execute[chronyd-systemd-daemon-reload]', :delayed
  end

  file "#{new_resource.systemd_system_dir}/chronyd.service.d/9999_after.conf" do
    action :delete

    notifies :run, 'execute[chronyd-systemd-daemon-reload]', :delayed
  end
end

# Inspec test for recipe chrony_ii::service

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

service_name = case os[:family]
               when 'redhat', 'amazon'
                 'chronyd'
               when 'debian'
                 'chrony'
               end

# Debian SysV script does not support status
service_supported = true
if os.debian? && os[:release].to_i <= 7
  service_supported = false
end

describe service(service_name) do
  it { should be_enabled }
  if service_supported
    it { should be_running }
  end
end

unless service_supported
  describe processes('chronyd') do
    it { should exist }
  end
end

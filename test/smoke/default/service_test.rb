# frozen_string_literal: true

# Inspec test for recipe chrony_ii::service

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

service_name = case os[:family]
               when 'redhat', 'amazon'
                 'chronyd'
               when 'debian'
                 'chrony'
               end

control 'Non-systemd service' do
  only_if('on non-systemd environment') do
    (os.name == 'amazon' && os.release.to_f < 2023) \
    || (os.name == 'ubuntu' && os.release.to_f < 16)
  end

  describe service(service_name) do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'systemd service' do
  only_if('on systemd environment') do
    !(
      (os.name == 'amazon' && os.release.to_f < 2023) \
      || (os.name == 'ubuntu' && os.release.to_f < 16)
    )
  end

  describe systemd_service(service_name) do
    it { should be_enabled }
    it { should be_running }
  end
end

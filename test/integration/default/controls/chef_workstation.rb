title 'Chef Workstation'

control 'Chef Workstation' do
  title 'Check if Chef Workstation is installed and properly configured'

  describe package('chef-workstation') do
    it { should be_installed }
  end

  describe file('/etc/profile.d/chef-init.sh') do
    it { should exist }
    its('mode') { should eq 0755 }
  end

  describe directory('/etc/skel/.chef') do
    it { should exist }
  end

  describe file('/etc/skel/.chef/config.rb') do
    it { should exist }
  end
end

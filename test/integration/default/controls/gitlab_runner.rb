title 'GitLab Runner'

control 'gitlab_runner' do
  title 'Check if GitLab Runner is installed and properly configured'

  describe user('gitlab-runner') do
    it { should exist }
    its('home') { should eq '/home/gitlab-runner' }
    its('shell') { should eq '/bin/bash' }
  end

  describe file('/usr/local/bin/gitlab-runner') do
    it { should exist }
    its('mode') { should eq 0777 }
  end

  describe file('/etc/gitlab-runner/config.toml') do
    it { should exist }
  end

  describe file('/etc/systemd/system/gitlab-runner.service') do
    it { should exist }
  end
end

# additional package installation
# used in recipe packages.rb
default['chef_work_environment']['packages']['gems'] = [
  {
    name: 'tecracer',
    version: '0.1.0',
  },
]

default['chef_work_environment']['packages']['from_source'] = [
  {
    name: 'tecracer',
    version: '0.1.0',
  },
]

# Chef Workstation installation
# used in recipe chef_workstation.rb
default['chef_work_environment']['chef_workstation']['source_path'] = nil
default['chef_work_environment']['chef_workstation']['version'] = nil

# GitLab Runner configurations
# used in recipe gitlab_runner.rb
# User settings
default['chef_work_environment']['gitlab_runner']['user']['name'] = 'gitlab'
default['chef_work_environment']['gitlab_runner']['user']['group'] = 'gitlab'
default['chef_work_environment']['gitlab_runner']['user']['uid'] = nil
default['chef_work_environment']['gitlab_runner']['user']['gid'] = nil
default['chef_work_environment']['gitlab_runner']['user']['home_dir'] = nil
default['chef_work_environment']['gitlab_runner']['user']['shell'] = '/bin/bash'

# GitLab Runner package specific
# Override the whole uri if points to a specific internal url
default['chef_work_environment']['gitlab_runner']['binary']['uri'] = nil
default['chef_work_environment']['gitlab_runner']['binary']['checksum'] = nil
# use only the version if you want to use the public uri for downloading the gitlab-runner
default['chef_work_environment']['gitlab_runner']['binary']['version'] = 'latest'

default['chef_work_environment']['gitlab_runner']['binary']['execution_path'] = '/usr/local/bin/gitlab-runner'

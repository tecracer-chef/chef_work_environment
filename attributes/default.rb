# This attribute file describes all attributes used in recipes.
# Every block is designed to be used in the specified recipe name itself.

################################
# `chef_workstation.rb`
# Chef Workstation installation
default['chef_work_environment']['chef_workstation']['source_path'] = nil
default['chef_work_environment']['chef_workstation']['version'] = nil
default['chef_work_environment']['chef_workstation']['shell'] = 'bash'
default['chef_work_environment']['chef_workstation']['chef_config']['ssl_verify'] = 'verify_none'

################################
# `gitlab_runner.rb`
# GitLab Runner configurations
# User settings
default['chef_work_environment']['gitlab_runner']['user']['name'] = 'gitlab-runner'
default['chef_work_environment']['gitlab_runner']['user']['group'] = 'gitlab-runner'
default['chef_work_environment']['gitlab_runner']['user']['uid'] = nil
default['chef_work_environment']['gitlab_runner']['user']['gid'] = nil
default['chef_work_environment']['gitlab_runner']['user']['home_dir'] = nil
default['chef_work_environment']['gitlab_runner']['user']['shell'] = '/bin/bash'

# GitLab Runner package specific
# Override the whole uri if points to a specific internal url
default['chef_work_environment']['gitlab_runner']['standalone_binary']['uri'] = 'https://s3.amazonaws.com/gitlab-runner-downloads/%<version>s/binaries/gitlab-runner-%<os_type>s'
default['chef_work_environment']['gitlab_runner']['standalone_binary']['checksum'] = '4db09579af248e714374b490ccc82d423518eee1377678d05fecc3d50816e55d'
# can be one out of the list: https://docs.gitlab.com/runner/install/bleeding-edge.html#download-the-standalone-binaries
default['chef_work_environment']['gitlab_runner']['standalone_binary']['os_type'] = 'linux-amd64'
# use only the version if you want to use the public uri for downloading the gitlab-runner (including starting v)
default['chef_work_environment']['gitlab_runner']['standalone_binary']['version'] = 'v13.6.0'
default['chef_work_environment']['gitlab_runner']['standalone_binary']['execution_path'] = '/usr/local/bin/gitlab-runner'

# Debian source
default['chef_work_environment']['source']['debian']['uri'] = 'https://packages.chef.io/repos/apt/stable'
default['chef_work_environment']['source']['debian']['key'] = 'https://packages.chef.io/chef.asc'

# yum source
default['chef_work_environment']['source']['rhel']['baseuri'] = 'https://packages.chef.io/repos/yum/stable/el/7/$basearch/'
default['chef_work_environment']['source']['rhel']['gpgkey'] = 'https://packages.chef.io/chef.asc'

# suse source
default['chef_work_environment']['source']['suse']['baseuri'] = 'https://packages.chef.io/repos/yum/stable/el/8/$basearch/'
default['chef_work_environment']['source']['suse']['gpgkey'] = 'https://packages.chef.io/chef.asc'

# GitLab Runner general configuration
default['chef_work_environment']['gitlab_runner']['config']['file'] = '/etc/gitlab-runner/config.toml'
default['chef_work_environment']['gitlab_runner']['config']['main']['concurrent'] = 1
default['chef_work_environment']['gitlab_runner']['config']['main']['check_interval'] = 0
default['chef_work_environment']['gitlab_runner']['config']['runners']['uri'] = 'https://gitlab.exampledomain.com'
default['chef_work_environment']['gitlab_runner']['config']['runners']['token'] = 'exampletoken'
default['chef_work_environment']['gitlab_runner']['config']['runners']['executor'] = 'bash'
default['chef_work_environment']['gitlab_runner']['config']['session_server']['session_timeout'] = 1800

################################
# `packages.rb`
# RHEL/CENTOS settings
default['chef_work_environment']['packages']['use_epel'] = true

# SUSE settings

# DEBIAN/UBUNTU settings

# additional package installation
default['chef_work_environment']['packages']['gems'] = nil
default['chef_work_environment']['packages']['from_source'] = nil

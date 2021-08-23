# This attribute file describes all attributes used in recipes.
# Every block is designed to be used in the specified recipe name itself.

################################
# `source_config.rb`
# Setting internal repositories
default['chef_work_environment']['source']['gems'] = 'https://rubygems.org'
default['chef_work_environment']['source']['omnitruck'] = 'https://omnitruck.chef.io/'
default['chef_work_environment']['source']['chef_server'] = 'https://api.chef.io/'
default['chef_work_environment']['source']['chef_server_org'] = 'example'
default['chef_work_environment']['source']['supermarket'] = 'https://supermarket.chef.io/'
default['chef_work_environment']['source']['debian']['uri'] = 'https://packages.chef.io/repos/apt/stable'
default['chef_work_environment']['source']['debian']['key'] = 'https://packages.chef.io/chef.asc'
default['chef_work_environment']['source']['rhel']['baseuri'] = 'https://packages.chef.io/repos/yum/stable/el/7/$basearch/'
default['chef_work_environment']['source']['rhel']['gpgkey'] = 'https://packages.chef.io/chef.asc'
default['chef_work_environment']['source']['suse']['baseuri'] = 'https://packages.chef.io/repos/yum/stable/el/8/$basearch/'
default['chef_work_environment']['source']['suse']['gpgkey'] = 'https://packages.chef.io/chef.asc'

# Internal package repositories (air gap envrionments)
default['chef_work_environment']['source']['debian']['internal'] = []

# default['chef_work_environment']['http_proxy'] = nil
# default['chef_work_environment']['https_proxy'] = nil

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
default['chef_work_environment']['gitlab_runner']['standalone_binary']['checksum'] = '9322be332d243718671d091913623336f3ae7422822521967658ba3b6d08a1c2'
# can be one out of the list: https://docs.gitlab.com/runner/install/bleeding-edge.html#download-the-standalone-binaries
default['chef_work_environment']['gitlab_runner']['standalone_binary']['os_type'] = 'linux-amd64'
# use only the version if you want to use the public uri for downloading the gitlab-runner (including starting v)
default['chef_work_environment']['gitlab_runner']['standalone_binary']['version'] = 'v13.10.0'
default['chef_work_environment']['gitlab_runner']['standalone_binary']['execution_path'] = '/usr/local/bin/gitlab-runner'

# GitLab Runner general configuration
default['chef_work_environment']['gitlab_runner']['config']['file'] = '/etc/gitlab-runner/config.toml'
default['chef_work_environment']['gitlab_runner']['config']['main']['concurrent'] = 1
default['chef_work_environment']['gitlab_runner']['config']['main']['check_interval'] = 0
default['chef_work_environment']['gitlab_runner']['config']['runners']['uri'] = 'https://gitlab.exampledomain.com'
default['chef_work_environment']['gitlab_runner']['config']['runners']['token'] = ''
default['chef_work_environment']['gitlab_runner']['config']['runners']['tags'] = []
default['chef_work_environment']['gitlab_runner']['config']['runners']['executor'] = 'shell'
default['chef_work_environment']['gitlab_runner']['config']['session_server']['session_timeout'] = 1800

################################
# `packages.rb`
# RHEL/CENTOS settings
default['chef_work_environment']['packages']['use_epel'] = true

# SUSE settings

# DEBIAN/UBUNTU settings

# additional package installation
default['chef_work_environment']['packages']['gems'] = nil
default['chef_work_environment']['packages']['system'] = nil

################################
# `repin.rb`
default['chef_work_environment']['repin'] = {}

################################
# `vault.rb`
default['chef_work_environment']['vault']['endpoint'] = ENV['VAULT_ADDR']
default['chef_work_environment']['vault']['token'] = ENV['VAULT_TOKEN']
default['chef_work_environment']['vault']['skip_verify'] = ENV['VAULT_SKIP_VERIFY']

default['chef_work_environment']['vault']['uri'] = 'https://releases.hashicorp.com/vault/1.7.0/vault_1.7.0_linux_amd64.zip'
default['chef_work_environment']['vault']['sha256'] = 'aad2f50635ef4e3f2495b0b6c855061c4047c795821fda886b326c1a71c71c35'

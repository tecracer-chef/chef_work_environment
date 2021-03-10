name 'chef_work_environment'

default_source :supermarket, 'https://supermarket.chef.io'
cookbook 'chef-client', '~> 12.3.3'
cookbook 'chef_work_environment', '~> 0.2.0'

run_list [
  'chef-client',
  'chef_work_environment',
  'chef_work_environment::vault'
]

default['chef_client'] = {
  'interval': 1800,
  'splay': 30,
}

default['chef_work_environment'] = {
  'chef_workstation': {
    'version': '21.2.303'
  }
}

default['chef_workstation'] = {
  'chef_work_environment': {
    # Put overrides for your managed workstations here
  }
}

default['gitlab_runner'] = {
  'chef_work_environment': {
    # Put overrides for your GitLab Runners here
  }
}

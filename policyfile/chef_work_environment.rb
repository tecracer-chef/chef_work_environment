name 'chef_work_environment'

default_source :supermarket, 'https://supermarket.chef.io'
cookbook 'chef-client', '~> 12.3.3'
cookbook 'chef_work_environment', '~> 0.2.0'

run_list [
  'chef-client',
  'chef_work_environment',
  'chef_work_environment::vault',
]

default['chef_client'] = {
  'interval': 1800,
  'splay': 30,
}

# Main attributes of the cookbook
default['chef_work_environment'] = {
  'chef_workstation': {
    'version': '21.3.346',
  },
}

# Policy group "developer" within this policy
default['developer'] = {
  'chef_work_environment': {
    # Put overrides for your managed developer workstations here
  },
}

# Policy group "gitlab_runner" within this policy
default['gitlab_runner'] = {
  'chef_work_environment': {
    # Put overrides for your GitLab Runners here
  },
}

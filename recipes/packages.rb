#
# Cookbook:: chef_work_environment
# Recipe:: packages
#
# Copyright:: 2020, Patrick Schaumburg, All Rights Reserved.

# Basic distribution packages

# TODO: Add yq as package in here again
# TODO: Add current major version

# TODO: See, if to use again
sys_packages = [
  {
    name: 'jq',
    version: '1.5',
  },
  {
    name: 'yamllint',
    version: '1.2.1',
  },
  {
    name: 'direnv',
    version: '2.7',
  },
]

# %w(jq yamllint direnv).each do |pkg|
#   next if node['platform_family'] == 'rhel' && pkg == 'direnv'
#   package pkg do
#     action :install
#   end
# end

# TODO: Re-enable this
# Additional distribution packages (controlled via attributes)
node['chef_work_environment']['packages']['from_distribution']&.each do |pkg|
  package pkg['name'] do
    version pkg['version']
    action :install
  end
end

# Basic gems
# TODO: Add current major version
%w(mdl overcommit chef-raketasks).each do |gem|
  gem_package gem do
    action :install
  end
end

# Additional gem packages (controlled via attributes)
node['chef_work_environment']['packages']['gems']&.each do |gem|
  gem_package gem['name'] do
    version gem['version']
    action :install
  end
end

# TODO: - vault cli: install = false
# -> extra recipe?

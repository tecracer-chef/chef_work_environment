#
# Cookbook:: chef_work_environment
# Recipe:: gitlab_runner
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# user 'gitlab-runner'
# download gitlab-runner
# install and configure gitlab-runner with attributes

gitlab_user = node['chef_work_environment']['gitlab_runner']['user']

user gitlab_user['name'] do
  comment 'The technical user for the gitlab-runner'
  uid gitlab_user['uid'] unless gitlab_user['uid'].nil?
  gid gitlab_user['gid'] unless gitlab_user['gid'].nil?
  home gitlab_user['home_dir'] unless gitlab_user['home_dir'].nil?
  manage_home true
  shell gitlab_user['shell']
  action :create # maybe modify, if really needed
end

gitlab_binary = node['chef_work_environment']['gitlab_runner']['standalone_binary']
log "https://s3.amazonaws.com/gitlab-runner-downloads/#{gitlab_binary['version']}/binaries/gitlab-runner-#{gitlab_binary['os_type']}"

remote_file gitlab_binary['execution_path'] do
  source gitlab_binary['uri'] unless gitlab_binary['uri'].nil?
  source "https://s3.amazonaws.com/gitlab-runner-downloads/#{gitlab_binary['version']}/binaries/gitlab-runner-#{gitlab_binary['os_type']}" unless gitlab_binary['version'].nil?
  checksum gitlab_binary['checksum']
  owner gitlab_user['name']
  group gitlab_user['group']
  mode '0777'
  action :create
end


# node.default['chef_work_environment']['gitlab_runner']['user']['working_dir'] = "/home/#{gitlab_user['name']}"
# execute "install_gitlab-runner_for_#{gitlab_user['name']}" do
#   command "#{gitlab_binary['execution_path']} install --user=#{gitlab_user['name']} --working-directory=#{node['chef_work_environment']['gitlab_runner']['user']['working_dir']}"
# end

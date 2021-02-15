#
# Cookbook:: chef_work_environment
# Recipe:: gitlab_runner
#
# Copyright:: 2020, The Authors, All Rights Reserved.

#######################################################
# user creation
gitlab_user = node['chef_work_environment']['gitlab_runner']['user']

gitlab_user_homedir = gitlab_user['home_dir'].nil? ? "/home/#{gitlab_user['name']}" : gitlab_user['home_dir']

group gitlab_user['group']

user gitlab_user['name'] do
  comment 'The technical user for the gitlab-runner'
  uid gitlab_user['uid'] unless gitlab_user['uid'].nil?
  gid gitlab_user['gid'] unless gitlab_user['gid'].nil?
  home gitlab_user_homedir
  manage_home true
  shell gitlab_user['shell']
  action :create # maybe modify, if really needed
end

#######################################################
# gitlab binary
gitlab_binary = node['chef_work_environment']['gitlab_runner']['standalone_binary']

remote_file gitlab_binary['execution_path'] do
  source format(gitlab_binary['uri'],
    version: gitlab_binary['version'],
    os_type: gitlab_binary['os_type']
    )
  checksum gitlab_binary['checksum']
  owner gitlab_user['name']
  group gitlab_user['group']
  mode '0777'
  action :create
end


#######################################################
# gitlab configuration
directory '/etc/gitlab-runner'

gitlab_config = node['chef_work_environment']['gitlab_runner']['config']

template gitlab_config['file'] do
  source 'gitlab-runner-config.toml.erb'
  variables(
    concurrent: gitlab_config['main']['concurrent'],
    check_interval: gitlab_config['main']['check_interval'],
    session_server_session_timeout: gitlab_config['session_server']['session_timeout'],
    runners_name: node['hostname'],
    runners_uri: gitlab_config['runners']['uri'],
    runners_token: gitlab_config['runners']['token'],
    runners_executor: gitlab_config['runners']['executor'],
  )
end

#######################################################
# gitlab service config
template '/etc/systemd/system/gitlab-runner.service' do
  source 'gitlab-runner-systemd.conf.erb'
  variables(
    executable: gitlab_binary['execution_path'],
    configfile: gitlab_config['file'],
    user: gitlab_user['name'],
    workdir: gitlab_user_homedir, # TODO: Feels wrong right now
  )
end

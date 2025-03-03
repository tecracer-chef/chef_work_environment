#
# Cookbook:: chef_work_environment
# Recipe:: gitlab_runner
#
# Copyright:: 2021, tecRacer Opensource, Apache-2.0.

#######################################################
# user creation
gitlab_user = node['chef_work_environment']['gitlab_runner']['user']

gitlab_user_homedir = gitlab_user['home_dir'] || "/home/#{gitlab_user['name']}"

group gitlab_user['group']

user gitlab_user['name'] do
  comment 'The technical user for the gitlab-runner'
  uid gitlab_user['uid'] unless gitlab_user['uid'].nil?
  gid gitlab_user['group']
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
# gitlab service config
gitlab_config = node['chef_work_environment']['gitlab_runner']['config']

systemd_unit 'gitlab-runner.service' do
  content <<~EOU
    [Unit]
    Description=GitLab Runner
    After=syslog.target network.target
    ConditionFileIsExecutable=#{gitlab_binary['execution_path']}

    [Service]
    StartLimitInterval=5
    StartLimitBurst=10
    ExecStart=#{gitlab_binary['execution_path']} "run" "--working-directory" "#{gitlab_user_homedir}" "--config" "#{gitlab_config['file']}" "--service" "gitlab-runner" "--syslog" "--user" "#{gitlab_user['name']}"

    Restart=always
    RestartSec=120

    [Install]
    WantedBy=multi-user.target

  EOU

  action [:create, :enable, :start]
end

#######################################################
# gitlab configuration
directory '/etc/gitlab-runner'

template gitlab_config['file'] do
  source 'gitlab-runner-config.toml.erb'
  variables(
    concurrent: gitlab_config['main']['concurrent'],
    check_interval: gitlab_config['main']['check_interval'],
    session_server_session_timeout: gitlab_config['session_server']['session_timeout'],
    runners_name: node['hostname'],
    runners_uri: gitlab_config['runners']['uri'],
    runners_token: gitlab_config['runners']['token'],
    runners_executor: gitlab_config['runners']['executor']
  )

  notifies :restart, 'systemd_unit[gitlab-runner.service]', :immediately
end

#######################################################
# gitlab registration
gitlab_runner = node['chef_work_environment']['gitlab_runner']['config']['runners']

execute 'Register Gitlab Runner' do
  command <<~SHELL
    gitlab-runner register \
       --tag-list #{gitlab_runner['tags'].join(',')} \
       --executor #{gitlab_runner['executor'] || 'shell'} \
       --non-interactive
  SHELL
  environment(
    CI_SERVER_URL: gitlab_runner['uri'],
    REGISTRATION_TOKEN: gitlab_runner['token'],
    REGISTER_LOCKED: false
  )
  sensitive true

  not_if { gitlab_runner['uri']&.empty? || gitlab_runner['token']&.empty? }
  not_if "gitlab-runner list 2>&1 | grep URL.*#{gitlab_runner['uri']}"

  notifies :reload, 'systemd_unit[gitlab-runner.service]', :immediately
end

name 'chef_work_environment'
maintainer 'tecRacer Opensource'
maintainer_email 'opensource@tecracer.de'
license 'Apache-2.0'
description 'Installs/Configures chef_work_environment'
version '0.1.0'

chef_version '>= 16.0'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
source_url 'https://github.com/tecracer-chef/chef_work_environment'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
issues_url 'https://github.com/tecracer-chef/chef_work_environment/issues'

# Dependencies
depends 'yum-epel', '~> 4.1.1'

# Supported OS
supports 'ubuntu'
supports 'debian'
supports 'redhat'
# supports 'suse'

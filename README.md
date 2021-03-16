# chef_work_environment

The cookbook provides an all in one installation and configuration for a commonly
used chef environment and includes source configuration, package installation and
CI/CD gitlab-runner installation.

## Supported OS

- Linux

## Usage

- Use json/attributes to set parameters
- Use default recipe in RunList for Chef Workstation install
- Use default recipe and `gitlab_runner` for Gitlab Runner install

```ruby
default['chef_work_environment']['packages']['gems'] = [
  {
    name: 'custom_cookstyle',
    version: '0.1.0',
  },
  {
    name: 'custom_raketaks',
    version: '0.1.0',
  },
  {
    name: 'cookbook_generator',
    version: '0.1.0',
  },
]
```

Note: These three examples point towards Gems you can use to create company-specific
packages without risking naming conflicts (as they will remain on 0.0.1 forever).

## Attributes

The used attributes can be found in the default attributes file

## Recipes

### default

- This recipe runs source_config, packages, chef_workstation recipes

### chef_workstation

- This recipe installs and configures the chef workstation based on the selected
  sources

### gitlab_runner

- This recipe installs and configures the gitlab runner based on an url and
  registers itself

### packages

- This recipe installs several default and always used packages and gems

### source_config

- This recipe is used for configuring different sources. It configures the official
  Chef APT and Redhat RPM repositories as well as Rubygems
- Optionally overrides the Debian standard package sources with those specified
  in the attributes

### vault

- This recipe installs the Vault binary to interact with Vault servers or start a
  local development one

## Systems without internet access

On Debian-based systems, use the `source_internal` recipe first to swap the
distribution standard sources with your internal mirrors:

__Attributes file__

```ruby
# Your attributes:
node['chef_work_environment']['source']['debian']['internal'] = [
  {
    'name': 'archive',
    'uri': 'https://internal.artifactory/archive.ubuntu/,
    'components': %w[main restricted],
    # 'key': 'https://internal.artifactory/api/gpg/key/public'
  },
  {
    'name': 'security',
    'uri': 'https://internal.mirror/security.ubuntu/',
    'components': %w[main restricted],
    # 'key': 'https://internal.artifactory/api/gpg/key/public'
  }
]
```

If you use internal signing, keep in mind that you need to manually add a GPG key
on Artifactory for this to work. If you do not do it, omit the key attribute completely.

On all supported Linux distributions, you can also override

- the default Gem source in `node['chef_work_environment']['source']['gems']`
- the Chef repository in `node['chef_work_environment'][DISTRIBUTION]['uri']`

## License and Authors

- Author: tecRacer OpenSource (opensource@tecracer.de)
- Copyright tecRacer
- Licensed under Apache-2.0

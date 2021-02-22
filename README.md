# chef_work_environment

The cookbook provides an all in one installation and configuration for a commonly
used chef environment and includes source configuration, package installation and
CI/CD gitlab-runner installation.

## Supported OS

- Windows 2012R2 and 2019

## Usage

- Use json/attributes to set parameters
- Use default recipe in RunList

```ruby
default['chef_work_environment']['packages']['gems'] = [
  {
    name: 'tecracer',
    version: '0.1.0',
  },
]
```

## Attributes

The used attributes can be found in the default attributes file

## Recipes

### default

- This recipe runs source_config, packages, chef_workstation, gitlab_runner recipes

### chef_workstation

- This recipe installs and configures the chef workstation based on the selected
  sources

### gitlab_runner

- This recipe installs and configures the gitlab runner based on an url and
  registers itself

### packages

- This recipe installs several default and always used packages and gems

### source_config

- This recipe is used for configuring different sources. Right now it is only
  configured to add the official chef apt and rpm sources

## License and Authors

- Author: tecRacer OpenSource (opensource@tecracer.de)
- Copyright tecRacer
- Licensed under Apache-2.0

# Simple heat template for Hybrid scenario

This is a simple heat template to support a hybrid scenario where there are no shared components between on-premise and off-premise OpenStack environments.

The template deploys a two tiered web application, examplified through a Wordpress front-end and a mariadb back-end on two different servers.
The wordpress server is automatically configured with the details of the database server.

## Scenario supported
In this thought scenario there is an Off-Premise environment and an On-Premise environment. The Off-Premise environment is used for development purposes and is less restrictive than the On-Premise environment, which is used for production.

The Off-Premise environment will always install the latest software versions directly from source repositories, while the On-Premise environment will use a frozen version captured at a point in time from the Off-Premise environment. In this example we capture an image of the instance with software installed to illustrate the frozen software version.

## Methodology used
Methodologies used to support this scenario are resource registry and nested templates. 

## Layout
- ./wordpress2-instances.yaml -- master template, consistent across all environments

- ./env_off-prem.yaml - environment file for Off-Premise environment. Holds deployment settings specific to the Off-Premise environment and resource registry for software components (install and configure)

- ./env_on-prem.yaml -- environment file for On-Premise environment. Holds deployment settings specific to the On-Premise environment and resource registry for software components (configure only)

- ./env_off-prem-freeze.yaml -- environment file for Off-Premise environment. Holds deployment settings specific to the Off-Premise environment and resource registry for software components (install only)

- ./templates/* -- child templates to handle different software scenarios (install and configure, install only, configure only)

- ./scripts/* -- scripts used to perform install and configure actions, used by child templates

## Example usage
### Deploy to Off-Prem (installs and configures software)
1. source off-prem-credentials.sh
1. heat stack-create web-dev-stack -f wordpress2-instances.yaml -e env_off-prem.yaml

### Freeze software version to export to On-Premise environment (installs software only)
1. source off-prem-credentials.sh
1. heat stack-create freeze-dev-version -f wordpress2-instances.yaml -e env_off-prem=freeze.yaml
1. use nova and glance to capture and export images with software installed

### Deploy to On-Premise (configures software only)
1. source on-prem-credentials
1. heat stack-create web-prod-stack -f wordpress2-instances.yaml -e env_on-prem.yaml


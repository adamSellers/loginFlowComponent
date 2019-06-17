# Location Aware Login Flow App

This repository provides a method to check a user's location upon login and pass that geolocation information through to a login flow. If a user's location is not within tolerance (set in the component setup in the Lightning flow builder), then the user is denied access to the services.

It is noted here that this is an example only, there will be more configuration required around permissions and users if considering deploying this into a customer community.

## Dev, Build and Test

This is a Salesforce DX app, ensure that you've taken the necessary steps to install and configure SFDX as listed [here](https://trailhead.salesforce.com/en/content/learn/modules/sfdx_app_dev/sfdx_app_dev_setup_dx).

Once installed, do the following to deploy this code to a scratch org.

```
sfdx force:org:create -a location -s -f ./config/project-scratch-def.json
```

Then push the source code:

```
sfdx force:source:push
```

Assign the permset

```
sfdx force:user:permset:assign -n LoginFlowComponentUser
```

Open the org and start to configure as necessary (create account and customer records as required)

```
sfdx force:org:open
```

## Resources

This app, once deployed, will require that the geolocation services for Shipping Addresses in the Account record are activated, instructions to do this [here](https://help.salesforce.com/articleView?id=data_dot_com_clean_admin_automatically_get_geocodes_for_addresses.htm&type=5).

## Description of Files and Directories

The repository consists of the following:

1. Apex class and associated test class that deploy the location logic code to the application. This class returns a boolean that is used in the flow to determine if a user can execute a login transaction.
2. Aura Component (as at creation date, LWC support for flows is still on the roadmap) that harvests the user's location (from the browser navigator.geolocation API) and a user specified branch code.
3. Account custom field changes to allow for the branch location to be entered against an account record.
4. Lightning Flow and Login flow configuration.

## Issues

- Login flow final stage, working with the returned boolean, needs finalisation - this is in an incomplete state ATM.

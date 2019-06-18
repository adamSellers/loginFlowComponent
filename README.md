# Location Aware Login Flow App

This repository provides a method to check a user's location upon login and pass that geolocation information through to a login flow. If a user's location is not within tolerance (set in the component setup in the Lightning flow builder), then the user is denied access to the services.

## Legal Notice

Copyright 2019, Adam Sellers - Sales Engineering, Salesforce.com Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.
- Neither the name of the salesforce.com nor the names of its contributors
  may be used to endorse or promote products derived from this software
  without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## Considerations for Use

It is noted here that this is an example only, there will be more configuration required around permissions and users if considering deploying this into a customer community. It is also noted, that this is an imperfect solution on location! Given that this solution takes the browser location from the geolocation API, things such as VPN's could cause incorrect reuslts.

## Dev, Build and Test

This is a Salesforce DX app, ensure that you've taken the necessary steps to install and configure SFDX as listed [here](https://trailhead.salesforce.com/en/content/learn/modules/sfdx_app_dev/sfdx_app_dev_setup_dx).

Once installed, authenticate a sandbox you wish to test in.

```
sfdx force:auth:web:login -a {yourUserAlias}
```

Once authenticated, do the following to deploy this code to your sandbox.

```
sfdx force:source:deploy -p ./force-app/ -u {yourUserAlias}
```

Once the source is deployed, there's some setup steps required in the sandbox itself.

1. Open the org (sfdx force:org:open -u {yourUserAlias}) and activate the Flow version.
2. Create the login flow, assigning it to your community user profile that you wish to test against.
3. Add the location code custom field to the Account page layout as required.
4. Assign the Permission Set LoginFlowComponentUser to the user(s) as required, or add the permissions found therein to the relevant profile.

## Resources

This function set, once deployed, will require that the geolocation services for Shipping Addresses in the Account record are activated, instructions to do this [here](https://help.salesforce.com/articleView?id=data_dot_com_clean_admin_automatically_get_geocodes_for_addresses.htm&type=5).

Note: This package doesn't work unless the geolocation fields are populated on the Shipping Address fields against the Account record. This package is provided as an example only, modify this for your own requirements.

## Description of Files and Directories

The repository consists of the following:

1. Apex class and associated test class that deploy the location logic code to the application. This class returns a boolean that is used in the flow to determine if a user can execute a login transaction.
2. Aura Component (as at creation date, LWC support for flows is still on the roadmap) that harvests the user's location (from the browser navigator.geolocation API) and a user specified branch code.
3. Account custom field changes to allow for the branch location to be entered against an account record.
4. Lightning Flow and Login flow configuration.

## Issues

None known, doesn't mean that none exist :) Will happily review PR's!

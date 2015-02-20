# simple-uber

This repo is a collection of some useful features that one can utilize from Uber. I created these snippets for a future update of one of our apps.

As of writing it does the following:
* Deeplinking to the Uber to ask for a quote when going to a certain place (Will open the web app if the iOS app is not found)
* Retrieving price estimates for Uber’s different services when going from point A to B.

# Usage

To use the snippets, you need a client ID and a server token which you can get from here: https://developer.uber.com/apps

In the sample app, the configuration for those variables is found on the info.plist file.

Based on what I experienced, you can’t test deeplinking properly on a simulator. The Uber website just shows an error.

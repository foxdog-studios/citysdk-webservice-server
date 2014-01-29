CitySDK Webservice server
-------------------------

A webservice server for the CitySDK

To add a webservice, add the gem to `Gemfile.local` (you will need to create
this file).

For an example of a webservice gem see
https://github.com/foxdog-studios/citysdk-webservice-met-office

The config is loaded from `config.yml`.

And example `config.yaml` for use with the met office gem would like this:

    routes:
      - citysdk_webservice_met_office
    datapointkey: your-data-point-key
    resolution: 3hourly

The `routes` list in the `config.yml` is a list of the names of the webservice
gems you want to use (at the moment you will need to make sure they are both in
this list and in the `Gemfile.local`)


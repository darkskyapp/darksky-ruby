# CHANGELOG

## 1.0.6

* Fixed API endpoint
* Added time_machine method to query historic data

## 1.0.5

* Updated gemspec to reflect new homepage. The repository has moved to https://github.com/darkskyapp/darksky-ruby.

## 1.0.4

* Added `brief_forecast` API endpoint to return a brief forecast for the latitude and longitude.

## 1.0.3

* Added `interesting` API endpoint to return a list of interesting storms happening right now.
* Fixed bug in `precipitation` API endpoint where multiple locations were not correctly passed to the API.

## 1.0.2

* Removed default to disable SSL peer verification now that the DarkSky API server has a signed certificate.

## 1.0.1

* Added `options` hash to API endpoints as final parameter.
* Default options for API endpoints disable SSL peer verification while DarkSky API is in beta and still uses a self-signed certificate.
* Fixed response parsing for `precipitation` API endpoint.

## 1.0.0

* Initial release.
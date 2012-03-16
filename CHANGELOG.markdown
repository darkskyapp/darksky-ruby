# CHANGELOG

## 1.0.3

* Added `interesting` API endpoint to return a list of interesting storms happening right now.

## 1.0.2

* Removed default to disable SSL peer verification now that the DarkSky API server has a signed certificate.

## 1.0.1

* Added `options` hash to API endpoints as final parameter.
* Default options for API endpoints disable SSL peer verification while DarkSky API is in beta and still uses a self-signed certificate.
* Fixed response parsing for `precipitation` API endpoint.

## 1.0.0 

* Initial release.
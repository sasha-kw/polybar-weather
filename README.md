# polybar-weather
A simple bash script to get weather conditions for use with [Polybar.](https://github.com/polybar/polybar)

## Dependencies

* `jq`
* [MET Norway API](https://api.met.no/)
* [Mozilla location API](https://location.services.mozilla.com/)

## Configuration

You may specify a latitude and longitude or leave these values blank and allow the script to guess your location using the Mozilla location API.

```sh
LAT="0.0"
LON="0.0"
SYMBOL="°C"
```

## Polybar module
```ini
[module/weather]
type = custom/script
exec = ~/.config/polybar/weather.sh
interval = 600
```


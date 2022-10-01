#!/bin/bash

LAT=""
LON=""
SYMBOL="°C"

get_icon() {
    case $1 in
        # Icons for weather-icons
       *clearsky*)                        icon="☀";;
       *cloudy*)                          icon="☁";;
       *fair*)                            icon="☀";;
       *fog*)                             icon="🌫";;
       *heavyrain*)                       icon="🌧";;
       *heavyrainandthunder*)             icon="⛈";;
       *heavyrainshowers*)                icon="🌧";;
       *heavyrainshowersandthunder*)      icon="⛈";;
       *heavysleet*)                      icon="🌧";;
       *heavysleetandthunder*)            icon="⛈";;
       *heavysleetshowers*)               icon="🌧";;
       *heavysleetshowersandthunder*)     icon="⛈";;
       *heavysnow*)                       icon="🌨";;
       *heavysnowandthunder*)             icon="⛈";;
       *heavysnowshowers*)                icon="🌨";;
       *heavysnowshowersandthunder*)      icon="⛈";;
       *lightrain*)                       icon="🌧";;
       *lightrainandthunder*)             icon="⛈";;
       *lightrainshowers*)                icon="🌧";;
       *lightrainshowersandthunder*)      icon="⛈";;
       *lightsleet*)                      icon="🌧";;
       *lightsleetandthunder*)            icon="⛈";;
       *lightsleetshowers*)               icon="🌧";;
       *lightsnow*)                       icon="🌨";;
       *lightsnowandthunder*)             icon="⛈";;
       *lightsnowshowers*)                icon="🌨";;
       *lightssleetshowersandthunder*)    icon="⛈";;
       *lightssnowshowersandthunder*)     icon="⛈";;
       *partlycloudy*)                    icon="⛅";;
       *rain*)                            icon="🌧";;
       *rainandthunder*)                  icon="⛈";;
       *rainshowers*)                     icon="🌧";;
       *rainshowersandthunder*)           icon="⛈";;
       *sleet*)                           icon="🌧";;
       *sleetandthunder*)                 icon="⛈";;
       *sleetshowers*)                    icon="🌧";;
       *sleetshowersandthunder*)          icon="⛈";;
       *snow*)                            icon="🌨";;
       *snowandthunder*)                  icon="⛈";;
       *snowshowers*)                     icon="🌨";;
       *snowshowersandthunder*)           icon="⛈";;
       *)                                 icon="❓";
    esac

    echo "$icon"
}

if [ -z "$LON" ] && [ -z "$LAT" ]; then
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)
    LAT="$(echo "$location" | jq '.location.lat')"
    LON="$(echo "$location" | jq '.location.lng')"
fi

response=$(curl -sf "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=$LAT&lon=$LON")

current_temperature=$(echo "$response" | jq ".properties.timeseries[0].data.instant.details.air_temperature")
current_conditions=$(echo "$response" | jq ".properties.timeseries[0].data.next_1_hours.summary.symbol_code")

echo "$(get_icon "$current_conditions") $current_temperature$SYMBOL"


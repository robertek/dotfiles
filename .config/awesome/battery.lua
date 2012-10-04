batterywidget = widget({type = "textbox", name = "batterywidget", align = "right" })

function batteryInfo(adapter)
  local fcur = io.open("/sys/class/power_supply/"..adapter.."/energy_now")
  local fcap = io.open("/sys/class/power_supply/"..adapter.."/energy_full")
  local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
  local fpow = io.open("/sys/class/power_supply/"..adapter.."/power_now")
  local cur = fcur:read()
  local cap = fcap:read()
  local sta = fsta:read()
  local pow = fpow:read()
  local battery = math.floor(cur * 100 / cap)
  local remaining = ""
  if sta:match("Charging") then
    remaining = math.floor( 60 * (cap - cur) / pow)
    remaining = math.floor(remaining/60).."h "..math.floor(remaining%60).."m"
    battery = "A/C ("..battery.."% "..remaining..")"
  elseif sta:match("Discharging") then
    if tonumber(battery) < 10 then
      naughty.notify({ title      = "Battery Warning"
                     , text       = "Battery low! "..battery.."% left!"
                     , timeout    = 5
                     , position   = "top_right"
                     , fg         = beautiful.fg_focus
                     , bg         = beautiful.bg_focus
                     })
    end
    remaining = math.floor( 60 * cur / pow)
    remaining = math.floor(remaining/60).."h "..math.floor(remaining%60).."m"
    battery = battery.."% "..remaining 
  else
    battery = "A/C"
  end
  batterywidget.text = "Bat: "..battery
  fcur:close()
  fcap:close()
  fsta:close()
  fpow:close()
end

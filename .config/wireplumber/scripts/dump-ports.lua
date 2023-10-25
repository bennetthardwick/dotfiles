-- Dump all Wireplumber ports

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ',\n'
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local port_om = ObjectManager {
  Interest {
    type = "port",
  }
}

port_om:connect("object-added", function (om, port)
  print(dump(port.properties) .. '\n\n')
end)

port_om:activate()

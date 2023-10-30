-- Dump all Wireplumber links

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

local link_om = ObjectManager {
  Interest {
    type = "link",
  }
}

link_om:connect("object-added", function (om, link)
  print(dump(link.properties) .. '\n\n')
end)

link_om:activate()

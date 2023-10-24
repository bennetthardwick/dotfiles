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

local null_sink_name = "stereo-null-sink"
local evo_name = "alsa_output.usb-Audient_Audient_EVO16-00.pro-output-0"
local link_desc = "auto-stereo-link"

stereo_sink_om = ObjectManager {
  Interest {
    type = "node",
    Constraint { "node.name", "in-list", null_sink_name, evo_name },
  }
}

link_om = ObjectManager {
  Interest {
    type = "link",
    Constraint { "node.description", "equals", link_desc }
  }
}

port_om = ObjectManager {
  Interest {
    type = "port",
    Constraint { "port.alias", "matches", "Audient EVO16:*" },
    Constraint { "port.direction", "equals", "in" }
  }
}
-- evo_output_port_om = ObjectManager {
--   Interest {
--     type = "port",
--     Constraint { "port.alias", "matches", "Audient EVO16:*" },
--     Constraint { "port.direction", "matches", "in" },
--     Constraint { "port.name", "in-list", "playback_AUX0", "playback_AUX1" }
--   }
-- }

function remove_link()
  -- for node in link_om:iterate() do
  --   node:request_destroy()
  -- end
end

function link_ports()
  remove_link()

  local stereo;
  local evo;

  for node in stereo_sink_om:iterate() do
    if node.properties["node.name"] == null_sink_name then
      stereo = node
    end

    if node.properties["node.name"] == evo_name then
      evo = node
    end
  end

  if stereo == nil or evo == nil then
    return
  end

  local stereo_l = stereo:lookup_port {
    Constraint { "port.direction", "equals", "out" },
    Constraint { "audio.channel", "equals", "FL" }
  }

  local stereo_r = stereo:lookup_port {
    Constraint { "port.direction", "equals", "out" },
    Constraint { "audio.channel", "equals", "FR" }
  }

  local evo_l
  local evo_r

  for port in port_om:iterate() do
    if port.properties["audio.channel"] == "AUX0" then
      evo_l = port
    end

    if port.properties["audio.channel"] == "AUX1" then
      evo_r = port
    end
  end

  if evo_l == nil or evo_r == nil then
    return
  end

  link_l_args = {
    ["link.input.node"] = evo.properties["object.id"],
    ["link.input.port"] = evo_l.properties["object.id"],

    ["link.output.node"] = stereo.properties["object.id"],
    ["link.output.port"] = stereo_l.properties["object.id"],
    
    ["object.id"] = nil,

    ["node.description"] = link_desc
  }

  link_r_args = {
    ["link.input.node"] = evo.properties["object.id"],
    ["link.input.port"] = evo_r.properties["object.id"],

    ["link.output.node"] = stereo.properties["object.id"],
    ["link.output.port"] = stereo_r.properties["object.id"],
    
    ["object.id"] = nil,

    ["node.description"] = link_desc
  }

  local link_l = Link("link-factory", link_l_args)
  local link_r = Link("link-factory", link_r_args)

  link_l:activate(1)
  link_r:activate(1)
end

stereo_sink_om:connect("object-added", function (om, node)
  link_ports();
end)

stereo_sink_om:connect("objects-changed", function (om, node)
  link_ports();
end)

stereo_sink_om:connect("object-removed", function (om, node)
  link_ports();
end)

port_om:connect("object-added", function (om, node)
  link_ports();
end)

stereo_sink_om:activate()
link_om:activate()
port_om:activate()


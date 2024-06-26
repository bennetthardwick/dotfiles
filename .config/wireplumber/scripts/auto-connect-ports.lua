-- As explained on: https://bennett.dev/auto-link-pipewire-ports-wireplumber/
--
-- This script keeps my stereo-null-sink connected to whatever output I'm currently using.
-- I do this so Pulseaudio (and Wine) always sees a stereo output plus I can swap the output
-- without needing to reconnect everything.

-- Link two ports together
function link_port(output_port, input_port)
  if not input_port or not output_port then
    return false
  end

  local link_args = {
    ["link.input.node"] = input_port.properties["node.id"],
    ["link.input.port"] = input_port.properties["object.id"],

    ["link.output.node"] = output_port.properties["node.id"],
    ["link.output.port"] = output_port.properties["object.id"],
    
    -- The node never got created if it didn't have this field set to something
    ["object.id"] = nil,

    -- I was running into issues when I didn't have this set
    ["object.linger"] = true,

    ["node.description"] = "Link created by auto_connect_ports"
  }

  local link = Link("link-factory", link_args)
  link:activate(1)

  return true
end

function delete_link(link_om, output_port, input_port)
  print("Trying to delete")

  if not input_port or not output_port then
    print("No ports")
    return false
  end

  local link = link_om:lookup {
    Constraint {
      "link.input.node", "equals", input_port.properties["node.id"]
    },
    Constraint {
      "link.input.port", "equals", input_port.properties["object.id"],
    },
    Constraint {
      "link.output.node", "equals", output_port.properties["node.id"],
    },
    Constraint {
      "link.output.port", "equals", output_port.properties["object.id"],
    }
  }

  if not link then

    print("No link!")

    return
  end

  print("Deleting link!")

  link:request_destroy()
end

-- Automatically link ports together by their specific audio channels.
--
-- ┌──────────────────┐         ┌───────────────────┐
-- │                  │         │                   │
-- │               FL ├────────►│ AUX0              │
-- │      OUTPUT      │         │                   │
-- │               FR ├────────►│ AUX1  INPUT       │
-- │                  │         │                   │
-- └──────────────────┘         │ AUX2              │
--                              │                   │
--                              └───────────────────┘
-- 
-- -- Call this method inside a script in global scope
--
-- auto_connect_ports {
--
--   -- A constraint for all the required ports of the output device 
--   output = Constraint { "node.name"}
--
--   -- A constraint for all the required ports of the input device 
--   input = Constraint { .. }
--
--   -- A mapping of output audio channels to input audio channels
--
--   connections = {
--     ["FL"] = "AUX0"
--     ["FR"] = "AUX1"
--   }
--
-- }
--
function auto_connect_ports(args)
  local output_om = ObjectManager {
    Interest {
      type = "port",
      args["output"],
      Constraint { "port.direction", "equals", "out" }
    }
  }

  local input_om = ObjectManager {
    Interest {
      type = "port",
      args["input"],
      Constraint { "port.direction", "equals", "in" }
    }
  }

  local all_links = ObjectManager {
    Interest {
      type = "link",
    }
  }

  local unless = nil

  if args["unless"] then
    unless = ObjectManager {
      Interest {
        type = "port",
        args["unless"],
        Constraint { "port.direction", "equals", "in" }
      }
    }

  end

  function _connect()
    local delete_links = unless and unless:get_n_objects() > 0

    print("Delete links", delete_links)

    for output_name, input_names in pairs(args.connect) do
      local input_names = input_names[1] == nil and { input_names } or input_names

      for _i, input_name in pairs(input_names) do
        local output = output_om:lookup { Constraint { "audio.channel", "equals", output_name } }
        local input =  input_om:lookup { Constraint { "audio.channel", "equals", input_name } }

        if delete_links then
          delete_link(all_links, output, input)
        else
          link_port(output, input)
        end
      end
    end
  end

  output_om:connect("object-added", _connect)
  input_om:connect("object-added", _connect)
  all_links:connect("object-added", _connect)

  output_om:activate()
  input_om:activate()
  all_links:activate()

  if unless then
    unless:connect("object-added", _connect)
    unless:connect("object-removed", _connect)
    unless:activate()
  end
end

-- Auto connect the stereo null sink to the first two channels of the EVO16
auto_connect_ports {
  output = Constraint { "object.path", "matches", "stereo-null-sink:*" },
  input = Constraint { "port.alias", "matches", "Audient EVO16:*" },
  connect = {
    ["FL"] = "AUX0",
    ["FR"] = "AUX1"
  }
}

-- Auto connect the stereo null sink to the jack_sink for when the jack server gets started
auto_connect_ports {
  output = Constraint { "object.path", "matches", "stereo-null-sink:*" },
  input = Constraint { "object.path", "matches", "jack_sink:*" },
  connect = {
    ["FL"] = "FL",
    ["FR"] = "FR"
  }
}

-- Auto connect the stereo null sink to the jack_sink for when the jack server gets started
auto_connect_ports {
  output = Constraint { "object.path", "matches", "stereo-null-sink:*" },
  input = Constraint { "object.path", "matches", "alsa:pcm:*" },
  connect = {
    ["FL"] = "FL",
    ["FR"] = "FR"
  },

  -- Don't connect to speakers if there are bluetooth headphones plugged in
  unless = Constraint { "object.path", "matches", "bluez_output.*" }
}

-- Auto connect the stereo null sink to bluetooth headphones
auto_connect_ports {
  output = Constraint { "object.path", "matches", "stereo-null-sink:*" },
  input = Constraint { "object.path", "matches", "bluez_output.*" },
  connect = {
    -- Connect to the correct channel or "MONO" if the output is in "headset" mode
    ["FL"] = { "FL", "MONO" },
    ["FR"] = { "FR", "MONO" }
  }
}

-- I swear none of this even works

table.insert(alsa_monitor.rules, {
    matches = {
      {
        { "node.name", "matches", "alsa_input.usb-Yamaha*" },
      },
      {
        { "node.name", "matches", "alsa_output.usb-Yamaha*" },
      },

      {
        { "node.name", "matches", "alsa_input.usb-Focusrite*" },
      },
      {
        { "node.name", "matches", "alsa_output.usb-Focusrite*" },
      },
    },
    apply_properties = {
      ["audio.rate"]    = 96000,
      -- ["audio.allowed-rates"]    = { 48000, 96000 192000 },
      ["api.alsa.period-size"]   = 64,
      ["api.alsa.disable-batch"] = true,
      ["session.suspend-timeout-seconds"] = 0,  -- 0 disables suspend
    }
})

table.insert(alsa_monitor.rules, {
    matches = {
      {
        { "client.name", "matches", "REAPER" },
      },
    },
    apply_properties = {
      ["node.description"] = "wow, reaps",
      ["node.latency"]    = "256/96000",
      ["node.lock-quantum"]    = true,
    }
})
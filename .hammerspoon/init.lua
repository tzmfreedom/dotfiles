local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function keyCodeSet(keys)
   return function()
      for i, keyEvent in ipairs(keys) do
         keyEvent()
      end
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

remapKey({ 'ctrl' }, ']',  keyCodeSet({
    keyCode('escape'),
    keyCode(";", {'ctrl', 'shift'}),
}))

hs.urlevent.bind("someAlert", function(eventName, params)
    hs.alert.show("Received someAlert")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

hs.hotkey.bind({"alt"}, "J", function()
  hs.application.launchOrFocus("IntelliJ IDEA 15")
end)

hs.hotkey.bind({"alt"}, "E", function()
  hs.application.launchOrFocus("Evernote")
end)

hs.hotkey.bind({"alt"}, "C", function()
  hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({"alt"}, "L", function()
  hs.application.launchOrFocus("LINE")
end)

hs.hotkey.bind({"alt"}, "S", function()
  hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind({"alt"}, "M", function()
  hs.application.launchOrFocus("MacVim")
end)

hs.alert.show("Config loaded")


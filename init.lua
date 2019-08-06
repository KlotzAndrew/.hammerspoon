function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
      if file:sub(-4) == ".lua" then
          doReload = true
      end
  end
  if doReload then
      hs.reload()
  end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

hs.hotkey.bind({"cmd", "ctrl"}, "l", function()
    os.execute("./lock.sh >& lock.log")
    hs.caffeinate.startScreensaver()
end)

function ssWatch(eventType)
	if (eventType == hs.caffeinate.watcher.screensaverDidStart) then
    -- hs.alert.show("screensaverDidStart")
	elseif (eventType == hs.caffeinate.watcher.screensDidLock) then
    -- hs.alert.show("screensDidLock!")
	end
end
local sWatcher = hs.caffeinate.watcher.new(ssWatch)
sWatcher:start()

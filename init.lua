
hs.application.enableSpotlightForNameSearches(true)

-- Reload the hammerspoon config file ( this file )
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.loadSpoon("ArrangeDesktop")
spoon.ArrangeDesktop.arrangements = spoon.ArrangeDesktop:_loadConfiguration()

-- Enable creating desktop window arrangments
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
  spoon.ArrangeDesktop:createArrangement()
end)

-- Default window arrangment, used for cycling through them
activeArrangement = "Default"

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", function()
  spoon.ArrangeDesktop:arrange("Default")
  activeArrangement = "Default"
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "T", function()
  spoon.ArrangeDesktop.arrangements = spoon.ArrangeDesktop:_loadConfiguration()
  spoon.ArrangeDesktop:arrange("Default")
  spoon.ArrangeDesktop:arrange("Terminal")
  activeArrangement = "Terminal"
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "G", function()
  spoon.ArrangeDesktop.arrangements = spoon.ArrangeDesktop:_loadConfiguration()
  spoon.ArrangeDesktop:arrange("Default")
  spoon.ArrangeDesktop:arrange("Chrome")
  activeArrangement = "Chrome"
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "A", function()
  spoon.ArrangeDesktop.arrangements = spoon.ArrangeDesktop:_loadConfiguration()
  spoon.ArrangeDesktop:arrange("Default")
  spoon.ArrangeDesktop:arrange("Arc")
  activeArrangement = "Arc"
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
    spoon.ArrangeDesktop.arrangements = spoon.ArrangeDesktop:_loadConfiguration()
    local nextA = nil
    local currA = nil
    local lastA = nil
    local firstA = nil
    
    if next(spoon.ArrangeDesktop.arrangements) ~= nil then
      for name, _ in pairs(spoon.ArrangeDesktop.arrangements) do
        if firstA == nil then
          firstA = name
        else
          lastA = name
        end

        if activeArrangement == name then
          currA = name
        elseif currA ~= nil then
          if nextA == nil then
            nextA = name
          end
        end

      end
    end
    
    if nextA ~= nil then
      spoon.ArrangeDesktop:arrange("Default")
      spoon.ArrangeDesktop:arrange(nextA)
      activeArrangement = nextA
    elseif currA == lastA then
      spoon.ArrangeDesktop:arrange("Default")
      spoon.ArrangeDesktop:arrange(firstA)
      activeArrangement = firstA
    end
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
    spoon.ArrangeDesktop.arrangements = spoon.ArrangeDesktop:_loadConfiguration()
    local beforeA = nil
    local currA = nil
    local prevA = nil
    local lastA = nil
    local firstA = nil
    
    if next(spoon.ArrangeDesktop.arrangements) ~= nil then
      for name, _ in pairs(spoon.ArrangeDesktop.arrangements) do
        if firstA == nil then
          firstA = name
        else
          lastA = name
        end

        if activeArrangement == name then
          currA = name
          if prevA ~= nil then
            beforeA = prevA
          end
        else
          prevA = name
        end
      end
    end
    
    if beforeA ~= nil then
      spoon.ArrangeDesktop:arrange("Default")
      spoon.ArrangeDesktop:arrange(beforeA)
      activeArrangement = beforeA
    elseif currA == firstA then
      spoon.ArrangeDesktop:arrange("Default")
      spoon.ArrangeDesktop:arrange(lastA)
      activeArrangement = lastA
    end
end)
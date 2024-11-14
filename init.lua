-- Define the portion of the left side of the screen to use (e.g., 55%)
local USABLE_PORTION = 0.55  -- 55% of the screen's width

-- Attempt to find the built-in display by exact name
local IMAC_DISPLAY_NAME = "Built-in Retina Display"
local imacScreen = hs.screen.find(IMAC_DISPLAY_NAME)

-- If not found by exact name, fallback to partial matching using 'Retina'
if not imacScreen then
    for _, screen in ipairs(hs.screen.allScreens()) do
        if string.find(screen:name(), "Retina") then
            imacScreen = screen
            print("DEBUG - Matched screen with partial name 'Retina':", imacScreen:name())
            break
        end
    end
end

-- Function to constrain windows within the specified left portion for the specified screen
local function constrainWindowToLeftPortion(win)
    if not imacScreen or not win:isStandard() then return end

    -- Only apply to windows on the iMac's specified screen
    if win:screen() == imacScreen then
        local screenFrame = imacScreen:frame()
        local winFrame = win:frame()
        local maxRight = screenFrame.x + (screenFrame.w * USABLE_PORTION)

        -- If the window extends beyond the usable portion to the right
        if winFrame.x + winFrame.w > maxRight then
            -- Shift the window left so it fits within the boundary
            winFrame.x = maxRight - winFrame.w
            if winFrame.x < screenFrame.x then
                -- If the window is wider than the usable portion, resize to fit
                winFrame.x = screenFrame.x
                winFrame.w = maxRight - screenFrame.x
            end
        end

        -- Ensure the window does not extend beyond the left edge of the screen
        if winFrame.x < screenFrame.x then
            winFrame.x = screenFrame.x
        end

        -- Update the window frame
        win:setFrame(winFrame)
    end
end

-- Subscribe to events for when windows are created, moved, or resized
hs.window.filter.default:subscribe({
    hs.window.filter.windowCreated,
    hs.window.filter.windowMoved,
    hs.window.filter.windowResized
}, constrainWindowToLeftPortion)

-- Adjust all currently open windows on the specified display at startup
for _, win in ipairs(hs.window.allWindows()) do
    constrainWindowToLeftPortion(win)
end

-- Notification that the script has loaded
hs.alert.show("Hammerspoon: Windows constrained on " .. IMAC_DISPLAY_NAME)

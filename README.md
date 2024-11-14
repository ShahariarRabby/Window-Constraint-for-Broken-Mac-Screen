
# **Hammerspoon Window Confinement Configuration**

This repository provides a Hammerspoon configuration script (`init.lua`) that confines application windows to a specified portion of the left side of an iMac’s built-in display. This setup is particularly useful for users with a partially broken screen who want to restrict window placement to the functional area of their display.

## **Table of Contents**

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## **Overview**

This Hammerspoon configuration script automatically adjusts the size and position of application windows so that they remain within a specified portion of the iMac’s built-in display. If the display is partially broken or unusable on the right side, this script ensures all windows stay on the left 55% (or a configurable portion) of the screen.

**Key Points:**
- Constrains windows on the **iMac’s built-in Retina display** to a specified portion of the screen.
- Leaves windows on other connected external displays unaffected.
- Automatically repositions and resizes windows to prevent them from moving into the unusable area.

## **Features**

- **Automatic Window Adjustment**: Keeps application windows within the defined usable portion of the screen.
- **Dynamic Constraints**: Automatically applies constraints when windows are created, moved, or resized.
- **Customizable Portion**: Users can adjust the percentage of the screen width used for displaying windows.
- **Supports Multiple Displays**: Specifically targets the iMac’s built-in display while allowing external displays to function normally.

## **Requirements**

- **macOS**: The script is developed and tested on macOS.
- **Hammerspoon**: You must have [Hammerspoon](https://www.hammerspoon.org/) installed on your Mac.

## **Installation**

1. **Install Hammerspoon** (if you haven’t already):
   - Download the latest release from [Hammerspoon.org](https://www.hammerspoon.org/) or [GitHub](https://github.com/Hammerspoon/hammerspoon/releases).
   - Move **Hammerspoon** to your **Applications** folder.
   - Open **Hammerspoon**, and it will prompt you to enable accessibility permissions in **System Settings > Privacy & Security > Accessibility**.

2. **Clone or Download this Repository**:
   ```bash
   git clone https://github.com/shahariarrabby/Hammerspoon-Window-Confinement.git
   ```
   Or download it as a ZIP and extract it.

3. **Copy the `init.lua` File**:
   - Move the `init.lua` file from the repository folder to your **`~/.hammerspoon/`** directory:
     ```bash
     cp Hammerspoon-Window-Confinement/init.lua ~/.hammerspoon/init.lua
     ```

4. **Reload Hammerspoon Configuration**:
   - Click on the Hammerspoon icon (🔨) in the menu bar.
   - Select **"Reload Config"** or use the default keyboard shortcut **Command + Shift + R**.
   - You should see the alert: **"Hammerspoon: Windows constrained on Built-in Retina Display"**.

## **Usage**

Once installed and loaded:
- **Automatic Constraints**: Whenever you open, move, or resize a window on your iMac’s built-in display, the script ensures the window remains within the defined usable portion (by default, 55% of the screen).
- **Window Movement**: If a window extends into the unusable area of the screen, it will be automatically repositioned to fit back into the usable portion.
- **External Monitors**: Windows on any connected external monitors remain unaffected and can be moved/resized normally.

## **Configuration**

You can customize the script to suit your needs. Open the `init.lua` file in a text editor to modify the following variables:

- **`USABLE_PORTION`**:  
  Defines the percentage of the screen width that windows should occupy on the iMac’s built-in display.  
  Example:
  ```lua
  local USABLE_PORTION = 0.55  -- 55% of the screen's width
  ```
  Adjust this value as needed, such as 0.5 for 50% or 0.6 for 60%.

- **`IMAC_DISPLAY_NAME`**:  
  Defines the name of the built-in iMac display. The script uses this name to target the correct screen.  
  Default:
  ```lua
  local IMAC_DISPLAY_NAME = "Built-in Retina Display"
  ```
  If necessary, adjust this name to match your display name as returned by `hs.screen.allScreens()`.

**Identifying the Correct Screen Name**:  
If the script cannot find the correct display:
1. Open the Hammerspoon console.
2. Run `hs.screen.allScreens()` or:
   ```lua
   for index, screen in ipairs(hs.screen.allScreens()) do
       print(index, "Screen Name:", screen:name())
   end
   ```
3. Use the exact screen name (e.g., `"Color LCD"`) found in the output in `IMAC_DISPLAY_NAME`.

## **Troubleshooting**

- **Screen Not Found**:
  If the console output shows `"Screen not found for name: Built-in Retina Display"`, ensure the `IMAC_DISPLAY_NAME` matches exactly the name returned by `hs.screen.allScreens()` for your display.
  
- **Windows Not Constrained**:
  Ensure that:
  1. Hammerspoon is running and the configuration is loaded.
  2. You have granted Hammerspoon accessibility permissions in **System Settings**.
  3. The `USABLE_PORTION` and `IMAC_DISPLAY_NAME` are correctly configured.
  4. You’re testing with windows on the built-in iMac display.

- **Partial Match for Screen Name**:
  If the exact screen name doesn’t work, the script includes a fallback partial name match using `"Retina"`. Adjust this substring if needed:
  ```lua
  if string.find(screen:name(), "Retina") then
      imacScreen = screen
  end
  ```

## **Contributing**

Contributions are welcome! If you’d like to improve this script or add features:
- Fork this repository.
- Create a new branch for your feature/bugfix.
- Make your changes and test thoroughly.
- Submit a pull request describing your changes and why they should be merged.

## **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

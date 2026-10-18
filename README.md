AI modified version of https://discord.com/channels/1161035767917850784/1553042955248603246/1554833950210265208 


(Make sure you are in the [HDR Den / Luma-Framework Discord server](https://discord.gg/Frc9Ry9nJ6) to remove the HDR colour grading so the modification works on SDR screens. 

This will likely not be needed in the future.  https://discord.gg/Frc9Ry9nJ6

https://github.com/Filoppi/Luma-Framework/issues/217


(I am not quite sure if the HDR pipeline is tied to upscaling for this modification, but this solution works for my SDR screen for now.)

Extract the files into the Persona 5 Strikers install directory and if on Linux ensure you have the correct DLL overrides in your launch options. If you are also using the P5StrikersFix modification it will be:

`WINEDLLOVERRIDES="dxgi=n,b;dinput8=n,b" %command%`

Gamescope can be used with: 

`WINEDLLOVERRIDES="dxgi=n,b;dinput8=n,b" %command% gamescope -W 3840 -H 2160 -w 3840 -h 2160 -f -g --force-grab-cursor -- %command%`

(P5StrikersFix has support for upscampling the HUD, and even at 4K the HUD still has aliasing.)


## Issues I found


If the window does not appear for the game after installing the addon, disable the Luma add-on by renaming it, launch the name, set the game to windowed mode or boarderless fullscreen, re-name the luma addon back to its original file name, and launch the game.

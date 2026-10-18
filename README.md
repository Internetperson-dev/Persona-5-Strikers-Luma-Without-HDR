AI modified version of beta version of [this version of the Luma Framework for Persona 5 Strikers](https://discord.com/channels/1161035767917850784/1553042955248603246/1554833950210265208)

(Make sure you are in the [HDR Den / Luma-Framework Discord server](https://discord.gg/Frc9Ry9nJ6) to remove the HDR colour grading so the modification works on SDR screens. 

This will likely not be needed in the future.  (See 
https://github.com/Filoppi/Luma-Framework/issues/217 )



(I am not quite sure if the HDR pipeline is tied to upscaling for this modification, but this solution works for my SDR screen for now.)

Extract the files into the Persona 5 Strikers install directory and if on Linux ensure you have the correct DLL overrides in your launch options. If you are also using the P5StrikersFix modification it will be:

`WINEDLLOVERRIDES="dxgi=n,b;dinput8=n,b" %command%`

You can also update the upscaler DLLs with these launch options if you are using Proton-GE (Which you likely are because it is the only way to prevent the opening videos from crashing the game.):

`WINEDLLOVERRIDES="dxgi=n,b;dinput8=n,b" PROTON_DLSS_UPGRADE=1 PROTON_FSR3_UPGRADE=1 PROTON_FSR4_UPGRADE=1 PROTON_XESS_UPGRADE=1 %command%`



P5StrikersFix has support for upscampling the HUD, and even at 4K the HUD still has aliasing without mods. Sadly I have never got these options working, so I would recommend using DLSS or FSR for the 3D elements, and using the [NN-Shaders](https://github.com/Sarenya/NN-Shaders) Reshade shader to handle aliasing the HUD. This is already included.)


## Issues I found


If the window does not appear for the game after installing the addon, disable the Luma add-on by renaming it (For example `Luma-Persona 5 Strikers.addon` to `Luma-Persona 5 Strikers.DISABLEDaddon` launch the game, set the game to windowed mode or boarderless fullscreen, re-name the Luma-addon back to its original file name (`Luma-Persona 5 Strikers.addon`), and launch the game.

AI modified version of https://discord.com/channels/1161035767917850784/1553042955248603246/1554833950210265208 (Make sure you are in the HDR Den  / Luma-Framework Discord server) to remove the HDR colour grading so the modification works on SDR screens. 

This will likely not be needed in the future.  https://discord.gg/Frc9Ry9nJ6

https://github.com/Filoppi/Luma-Framework/issues/217


(I am not quite sure if the HDR pipeline is tied to upscaling for this modfiication, but this solution works for my SDR screen for now.)

Extract the files into the Persona 5 Strikers install directory and if on Linux ensure you have the correct DLL overrides in your launch options. If you are also using the P5StrikersFix modification it will be:

`WINEDLLOVERRIDES="dxgi=n,b;dinput8=n,b" %command%`


Upscamping with Gamescope can also help the quality of the HUD.

This can be done with using the launch options.

`WINEDLLOVERRIDES="dxgi=n,b;dinput8=n,b" %command% gamescope -W 3840 -H 2160 -w 3840 -h 2160 -f -g --force-grab-cursor -- %command%`

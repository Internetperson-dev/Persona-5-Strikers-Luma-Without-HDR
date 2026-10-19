AI modified version of beta version of [this version of the Luma Framework for Persona 5 Strikers](https://discord.com/channels/1161035767917850784/1553042955248603246/1554833950210265208)

(Make sure you are in the [HDR Den / Luma-Framework Discord server](https://discord.gg/Frc9Ry9nJ6) for the link to work.

I (had AI) remove the HDR colour grading so the modification works on SDR screens. 

This will likely not be needed in the future.  (See 
https://github.com/Filoppi/Luma-Framework/issues/217 )



(I am not quite sure if the HDR pipeline is tied to upscaling for this modification, but this solution works for my SDR screen for now.)


Download the files using this button on GitHub.

<img width="740" height="438" alt="image" src="https://github.com/user-attachments/assets/1b45f021-16b3-4ef7-b661-0a225ae77b7d" />

After that, extract the files into the Persona 5 Strikers install directory.

It should look something like this:
```
📁 P5S/
├── 📄 amd_ags_x64.dll
├── 📁 data/
├── 📄 dinput8.dll
├── 📄 dxgi.dll
├── 📄 game.exe
├── 📁 license/
├── 📁 Luma/
├── 📄 Luma-Persona 5 Strikers.addon
├── 📄 nvngx_dlss.dll
├── 📄 ReShade.ini
├── 📄 ReShade2.ini
├── 📄 ReShadePreset.ini
├── 📁 reshade-shaders/
├── 📄 steam_api64.dll
└── 📄 steam_appid.txt
```

If you are on Linux ensure you have the correct DLL overrides in your launch options. If you are also using the P5StrikersFix modification it will be:

`WINEDLLOVERRIDES="dxgi=n,b;dinput8=n,b" %command%`

You can also update the upscaler DLLs with these launch options if you are using Proton-GE (Which you likely are because it is the only way to prevent the opening videos from crashing the game.):

`WINEDLLOVERRIDES="dxgi=n,b;dinput8=n,b" PROTON_DLSS_UPGRADE=1 PROTON_FSR3_UPGRADE=1 PROTON_FSR4_UPGRADE=1 PROTON_XESS_UPGRADE=1 %command%`



P5StrikersFix has support for upscampling the HUD, and even at 4K the HUD still has aliasing without mods. Sadly I have never got these options working, so I would recommend using DLSS or FSR for the 3D elements, and using the [NN-Shaders](https://github.com/Sarenya/NN-Shaders) Reshade shader to handle aliasing the HUD. This is already included.)


## Issues I found


If the window does not appear for the game after installing the add-on, disable the Luma add-on by renaming it (For example `Luma-Persona 5 Strikers.addon` to `Luma-Persona 5 Strikers.DISABLEDaddon` launch the game, set the game to windowed mode or borderless full screen, re-name the Luma-addon back to its original file name (`Luma-Persona 5 Strikers.addon`), and launch the game.

## Credits

### Luma-Framework

### Reshade and ReShadeUI.fxh

Copyright 2014 Patrick Mours. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
  * Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


### ReShade.fxh

SPDX-License-Identifier: CC0-1.0

### NN-Shaders (nnaa.fx)

MIT License

Copyright (c) 2025 Léo Calvis

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. 

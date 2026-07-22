# 📜 DexDL - MangaDex CLI

## ▶️ One-Command Install (for lazy people's)
### ![Platform](https://img.shields.io/badge/OS-Termux-green)
```bash
curl -sL https://raw.githubusercontent.com/UnKnowNModder/dexdl/master/termux-install.sh | sed 's/\r$//' | bash
```

### Windows (PowerShell + WSL)
The current DexDL binary is Linux-native, so Windows uses WSL to run it. Install WSL first if needed, open PowerShell, and run:
```powershell
irm https://raw.githubusercontent.com/UnKnowNModder/DexDL/master/windows-install.ps1 | iex
```
The installer adds a `dexdl` command to your user PATH. Open a new terminal after installation. If you have multiple WSL distributions, pass one explicitly:
```powershell
& .\windows-install.ps1 -DistroName Ubuntu
```

## Usage Examples
### URL:
- you can use the url from the mangadex.org, like this example below
```bash
dexdl https://mangadex.org/title/3bb0279f-a01d-4aa4-93e4-305800f4b83e/akatsuki-no-yona
```

### MANGA-ID:
- or you can simply put the manga-id from the url itself, both works.
```bash
dexdl 3bb0279f-a01d-4aa4-93e4-305800f4b83e
```

### 📚 SOMEWHAT USEFUL?:
- if you go from the method mentioned above, you'll be asked to input range of chapters anyways, but you can do it in one line aswell, e.g. chapter 112 to chapter 115 (4 chapters)
```bash
dexdl 3bb0279f-a01d-4aa4-93e4-305800f4b83e 112 115
```
### 💢 Important Note:
- this currently supports english translated manga only, so any language other than this will result in an empty pdf of the specific chapter.
- it won't be able to download manga that are uploaded by other sources on mangadex.org, like (self-uploaded) and certain sources available on mangadex uploads.

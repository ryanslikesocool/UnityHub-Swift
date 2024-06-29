# Unity Hub (Swift)
A [Unity Hub](https://unity.com/unity-hub) alternative, built natively for macOS.

## Features
(The official version doesn't have features marked with ✨!)
✨ Fully native UI and technology (Electron-free, Apple Silicon-native), loads instantly
✨ Smaller visual footprint
✨ Custom project icons for quick identification
✨ View useful project information without opening in Unity
✨ Enhanced search
✨ Quick links to documentation

# TODO
✨ Improved background modes
✨ Smarter editor installation
✨ Single module uninstall

- Get installed modules per Unity version via modules.json
- Install Unity versions and modules (requires official [Unity Hub](https://unity3d.com/get-unity/download) for CLI tools)

![Projects view](images/Projects.png) 
![Installs view](images/Installs.png) 

## Tips
**Hiding the official Unity Hub application from the dock**
- Locate Unity Hub.app in the Applications folder
- Right click > Show Package Contents
- Open Info.plist, located in the Contents folder, with Xcode
- Add a new property, titled `LSUIElement` and set the value to `YES`
- If Unity Hub is open, quit it and make sure it's not in the dock

## Known Issues
- The app cannot be sandboxed due to command line usage

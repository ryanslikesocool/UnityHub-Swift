# Unity Hub Swift
Unity Hub, rebuilt for macOS with SwiftUI

## Features
(The official app doesn't have features tagged with ✨!)
- Find Unity versions with default and custom locations
- Get installed modules per Unity version via modules.json
- Load projects, added via manual location
- Install Unity versions and modules (requires official [Unity Hub](https://unity3d.com/get-unity/download) for CLI tools)
- ✨ Emoji tags for projects (emoji picker powered by [Smile](https://github.com/onmyway133/Smile))
- ✨ Pinned projects
- Project search
- Unity version tags (alpha, beta, LTS)
- Default Unity version for new projects
- Version uninstall
- ✨ Single module uninstall
- ✨ File size display for projects, versions, and modules

![Projects view](images/Projects.png) 
![Installs view](images/Installs.png) 

## Tips
**Hiding the official Unity Hub application from the dock**
- Locate Unity Hub.app in the Applications folder
- Right click > Show Package Contents
- Open Info.plist, located in the Contents folder, with Xcode
- Add a new property, titled `LSUIElement` and set the value to `YES`
- If Unity Hub is open, quit in and make sure it's not in the dock

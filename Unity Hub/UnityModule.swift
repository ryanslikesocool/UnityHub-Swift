//
//  UnityModule.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import Foundation
import SwiftUI

enum UnityModule {
    case macOSMono
    case macOSIL2CPP
    case windowsMono
    case windowsIL2CPP
    case linuxMono
    case linuxIL2CPP
    case iOS
    case tvOS
    case android
    case documentation
    case androidSDKBuildTools
    case androidSDKPlatforms
    case androidSDKPlatformTools
    case androidNDK
    case androidOpenJDK
    case samsungTV
    case tizen
    case vuforia
    case webgl
    case facebook
    case facebookgameroom
    case lumin
    case standardAssets
    case exampleProjects
}

extension UnityModule: RawRepresentable {
    // json id
    typealias RawValue = String
    
    init?(rawValue: String) {
        switch rawValue {
        case "mac-mono": self = .macOSMono
        case "mac-il2cpp": self = .macOSIL2CPP
        case "windows-mono": self = .windowsMono
        case "windows-il2cpp": self = .windowsIL2CPP
        case "linux-mono": self = .linuxMono
        case "linux-il2cpp": self = .linuxIL2CPP
        case "ios": self = .iOS
        case "appletv": self = .tvOS
        case "android": self = .android
        default: return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .documentation: return "documentation"
        case .standardAssets: return "standardassets"
        case .exampleProjects: return "exampleprojects"
        case .android: return "android"
        case .androidSDKBuildTools: return "android-sdk-build-tools"
        case .androidSDKPlatforms: return "android-sdk-platforms"
        case .androidSDKPlatformTools: return "android-sdk-platform-tools"
        case .androidNDK: return "android-ndk"
        case .androidOpenJDK: return "android-open-jdk"
        case .iOS: return "ios"
        case .tvOS: return "appletv"
        case .linuxMono: return "linux-mono"
        case .linuxIL2CPP: return "linux-il2cpp"
        case .macOSMono: return "mac-mono"
        case .macOSIL2CPP: return "mac-il2cpp"
        case .samsungTV: return "samsungtv"
        case .tizen: return "tizen"
        case .vuforia: return "vuforia"
        case .webgl: return "webgl"
        case .windowsMono: return "windows-mono"
        case .windowsIL2CPP: return "windows-il2cpp"
        case .facebook: return "facebook"
        case .facebookgameroom: return "facebookgameroom"
        case .lumin: return "lumin"
        }
    }
    
    func getDisplayName() -> String? {
        switch self {
        case .macOSMono, .macOSIL2CPP: return "macOS"
        case .windowsMono, .windowsIL2CPP: return "Windows"
        case .linuxMono, .linuxIL2CPP: return "Linux"
        case .iOS: return "iOS"
        case .tvOS: return "tvOS"
        case .android: return "Android"
        default: return nil
        }
    }
    
    func getIcon() -> AnyView? {
        switch self {
        case .macOSMono, .macOSIL2CPP: return AnyView(SVGShapes.macOS())
        case .windowsMono, .windowsIL2CPP: return AnyView(SVGShapes.Windows())
        case .linuxMono, .linuxIL2CPP: return AnyView(SVGShapes.Linux())
        case .iOS: return AnyView(SVGShapes.iOS())
        case .tvOS: return AnyView(SVGShapes.tvOS())
        case .android: return AnyView(SVGShapes.Android())
        default: return nil
        }
    }
    
    func getInstallPath() -> String? {
        switch self {
        case .standardAssets: return "{UNITY_PATH}/Standard Assets"
        case .exampleProjects: return "/Users/Shared/Unity"
        case .android: return "{UNITY_PATH}/PlaybackEngines/AndroidPlayer"
        case .androidSDKBuildTools: return "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/SDK/build-tools"
        case .androidSDKPlatforms: return "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/SDK/platforms"
        case .androidSDKPlatformTools: return "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/SDK"
        case .androidNDK: return "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/NDK"
        case .androidOpenJDK: return "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/OpenJDK"
        case .iOS: return "{UNITY_PATH}/PlaybackEngines"
        case .tvOS: return "{UNITY_PATH}/PlaybackEngines/AppleTVSupport"
        case .linuxMono, .linuxIL2CPP: return "{UNITY_PATH}/PlaybackEngines/LinuxStandaloneSupport"
        case .macOSMono, .macOSIL2CPP: return "{UNITY_PATH}/Unity.app/Contents/PlaybackEngines/MacStandaloneSupport"
        case .samsungTV: return "{UNITY_PATH}/PlaybackEngines/STVPlayer"
        case .tizen: return "{UNITY_PATH}/PlaybackEngines/TizenPlayer"
        case .vuforia: return "{UNITY_PATH}/PlaybackEngines/VuforiaSupport"
        case .webgl: return "{UNITY_PATH}/PlaybackEngines/WebGLSupport"
        case .windowsMono, .windowsIL2CPP: return "{UNITY_PATH}/PlaybackEngines/WindowsStandaloneSupport"
        case .facebook: return "{UNITY_PATH}/PlaybackEngines/Facebook"
        case .lumin: return "{UNITY_PATH}/PlaybackEngines/LuminSupport"
        case .facebookgameroom: return nil
        default:
            if (self.rawValue.hasPrefix("language-")) {
                return "{UNITY_PATH}/Unity.app/Contents/Localization";
            }
            return "{UNITY_PATH}"
        }
    }
}

extension UnityModule: CaseIterable, Identifiable {
    var id: String {
        return self.rawValue
    }
}

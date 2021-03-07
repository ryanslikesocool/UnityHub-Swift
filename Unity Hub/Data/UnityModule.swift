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
    case androidSDKNDKTools
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
        case .androidSDKNDKTools: return "android-sdk-ndk-tools"
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
        case .macOSMono: return "macOS (mono)"
        case .macOSIL2CPP: return "macOS (IL2CPP)"
        case .windowsMono: return "Windows (Mono)"
        case .windowsIL2CPP: return "Windows (IL2CPP)"
        case .linuxMono: return "Linux (Mono)"
        case .linuxIL2CPP: return "Linux (IL2CPP)"
        case .iOS: return "iOS"
        case .tvOS: return "tvOS"
        case .android: return "Android"
        case .lumin: return "Lumin OS (Magic Leap)"
        case .webgl: return "WebGL"
        case .androidOpenJDK: return "Open JDK"
        case .androidSDKNDKTools: return "Android SDK/NDK Tools"
        default: return nil
        }
    }
    
    func getPlatform() -> String? {
        switch self {
        case .macOSMono, .macOSIL2CPP: return "macOS"
        case .windowsMono, .windowsIL2CPP: return "Windows"
        case .linuxMono, .linuxIL2CPP: return "Linux"
        case .iOS: return "iOS"
        case .tvOS: return "tvOS"
        case .android: return "Android"
        case .lumin: return "Lumin"
        case .webgl: return "WebGL"
        default: return ""
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
        case .standardAssets: return "/Standard Assets"
        case .exampleProjects: return "/Users/Shared/Unity"
        case .android: return "/PlaybackEngines/AndroidPlayer"
        case .androidSDKBuildTools: return "/PlaybackEngines/AndroidPlayer/SDK/build-tools"
        case .androidSDKPlatforms: return "/PlaybackEngines/AndroidPlayer/SDK/platforms"
        case .androidSDKPlatformTools: return "/PlaybackEngines/AndroidPlayer/SDK"
        case .androidNDK: return "/PlaybackEngines/AndroidPlayer/NDK"
        case .androidOpenJDK: return "/PlaybackEngines/AndroidPlayer/OpenJDK"
        case .iOS: return "/PlaybackEngines/iOSSupport"
        case .tvOS: return "/PlaybackEngines/AppleTVSupport"
        case .linuxMono, .linuxIL2CPP: return "/PlaybackEngines/LinuxStandaloneSupport"
        case .macOSMono, .macOSIL2CPP: return "/Unity.app/Contents/PlaybackEngines/MacStandaloneSupport"
        case .samsungTV: return "/PlaybackEngines/STVPlayer"
        case .tizen: return "/PlaybackEngines/TizenPlayer"
        case .vuforia: return "/PlaybackEngines/VuforiaSupport"
        case .webgl: return "/PlaybackEngines/WebGLSupport"
        case .windowsMono, .windowsIL2CPP: return "/PlaybackEngines/WindowsStandaloneSupport"
        case .facebook: return "/PlaybackEngines/Facebook"
        case .lumin: return "/PlaybackEngines/LuminSupport"
        case .facebookgameroom: return nil
        default:
            if (self.rawValue.hasPrefix("language-")) {
                return "/Unity.app/Contents/Localization";
            }
            return ""
        }
    }
    
    static func getAvailableModules() -> [UnityModule] {
        return [
            .android,
            .androidOpenJDK,
            .androidSDKNDKTools,
            .iOS,
            .tvOS,
            .linuxMono,
            .linuxIL2CPP,
            .macOSIL2CPP,
            .webgl,
            .windowsMono,
            .lumin
        ]
    }
}

extension UnityModule: CaseIterable, Identifiable {
    var id: String {
        return self.rawValue
    }
}

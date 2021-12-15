import Foundation
import SwiftUI

enum UnityModule: String {
    case none = ""
    case macOSMono = "mac-mono"
    case macOSIL2CPP = "mac-il2cpp"
    case windowsMono = "window-mono"
    case linuxMono = "linux-mono"
    case linuxIL2CPP = "linux-il2cpp"
    case iOS = "ios"
    case tvOS = "appletv"
    case android = "android"
    case androidSDKNDKTools = "android-sdk-ndk-tools"
	case documentation = "documentation"
    case androidSDKBuildTools = "android-sdk-build-tools"
    case androidSDKPlatforms = "android-sdk-platforms"
    case androidSDKPlatformTools = "android-sdk-platform-tools"
    case androidNDK = "android-ndk"
    case androidOpenJDK = "android-open-jdk"
    case webgl = "webgl"
    case lumin = "lumin"
}

extension UnityModule {
    var displayName: String? {
        switch self {
        case .macOSMono: return "macOS (mono)"
        case .macOSIL2CPP: return "macOS (IL2CPP)"
        case .windowsMono: return "Windows (Mono)"
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

    var platform: String? {
        switch self {
        case .macOSMono, .macOSIL2CPP: return "macOS"
        case .windowsMono: return "Windows"
        case .linuxMono, .linuxIL2CPP: return "Linux"
        case .iOS: return "iOS"
        case .tvOS: return "tvOS"
        case .android: return "Android"
        case .lumin: return "Lumin"
        case .webgl: return "WebGL"
        default: return ""
        }
    }

    /* func getIcon() -> AnyView? {
         switch self {
         case .macOSMono, .macOSIL2CPP: return AnyView(SVGShapes.macOS())
         case .windowsMono: return AnyView(SVGShapes.Windows())
         case .linuxMono, .linuxIL2CPP: return AnyView(SVGShapes.Linux())
         case .iOS: return AnyView(SVGShapes.iOS())
         case .tvOS: return AnyView(SVGShapes.tvOS())
         case .android: return AnyView(SVGShapes.Android())
         case .webgl: return AnyView(SVGShapes.WebGL())
         default: return nil
         }
     } */

    var installPath: String? {
        switch self {
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
        case .webgl: return "/PlaybackEngines/WebGLSupport"
        case .windowsMono: return "/PlaybackEngines/WindowsStandaloneSupport"
        case .lumin: return "/PlaybackEngines/LuminSupport"
        default:
            if rawValue.hasPrefix("language-") {
                return "/Unity.app/Contents/Localization"
            }
            return ""
        }
    }

    var hasChildModules: Bool {
        switch self {
        case .android: return true
        default: return false
        }
    }

    static func getAvailableModules() -> [UnityModule] {
        return [
            .android,
            .iOS,
            .tvOS,
            .linuxMono,
            .linuxIL2CPP,
            .macOSIL2CPP,
            .webgl,
            .windowsMono,
            .lumin,
        ]
    }
}

extension UnityModule: CaseIterable, Identifiable {
    var id: String {
        return rawValue
    }
}

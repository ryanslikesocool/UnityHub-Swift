import Foundation
import SwiftUI

enum UnityModule {
    case none
    case macOSMono
    case macOSIL2CPP
    case windowsMono
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
    case webgl
    case lumin
}

extension UnityModule: RawRepresentable {
    init?(rawValue: String) {
        switch rawValue {
        case "mac-mono": self = .macOSMono
        case "mac-il2cpp": self = .macOSIL2CPP
        case "windows-mono": self = .windowsMono
        case "linux-mono": self = .linuxMono
        case "linux-il2cpp": self = .linuxIL2CPP
        case "ios": self = .iOS
        case "appletv": self = .tvOS
        case "android": self = .android
        case "webgl": self = .webgl
        default: return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .documentation: return "documentation"
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
        case .webgl: return "webgl"
        case .windowsMono: return "windows-mono"
        case .lumin: return "lumin"
        default: return ""
        }
    }
    
    func getDisplayName() -> String? {
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
    
    func getPlatform() -> String? {
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
    
    func getIcon() -> AnyView? {
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
    }
    
    func getInstallPath() -> String? {
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
            if self.rawValue.hasPrefix("language-") {
                return "/Unity.app/Contents/Localization"
            }
            return ""
        }
    }
    
    func hasChildModules() -> Bool {
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
            .lumin
        ]
    }
}

extension UnityModule: CaseIterable, Identifiable {
    var id: String {
        return self.rawValue
    }
}

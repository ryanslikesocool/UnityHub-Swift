import Foundation

class Release {
    let firstVersionWithDocumentation = UnityVersion("2018.2.0a1")
}

struct DownloadInfo {
    let name: String
    let url: URL
    let version: String
    let encompassing: [DownloadInfo]?
    //let main: Bool
    let installedSize: Float //MB
    let downloadSize: Float //MB
    let renameFrom: String?
    let renameTo: String?
    
    static var androidSDKNDKInfo: [DownloadInfo] {
        return [
            DownloadInfo(name: "Android SDK & NDK Tools",
                         url: URL(string: "https://dl.google.com/android/repository/sdk-tools-darwin-4333796.zip")!,
                         version: "26.1.1",
                         encompassing: [
                            DownloadInfo(name: "Android SDK Platform Tools",
                                         url: URL(string: "https://dl.google.com/android/repository/platform-tools_r28.0.1-darwin.zip")!,
                                         version: "28.0.1",
                                         encompassing: nil,
                                         installedSize: 15.7,
                                         downloadSize: 4.55,
                                         renameFrom: nil,
                                         renameTo: nil
                            ),
                            DownloadInfo(name: "Android SDK Build Tools",
                                         url: URL(string: "https://dl.google.com/android/repository/build-tools_r28.0.3-macosx.zip")!,
                                         version: "28.0.3",
                                         encompassing: nil,
                                         installedSize: 120,
                                         downloadSize: 52.6,
                                         renameFrom: "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/SDK/build-tools/android-9",
                                         renameTo: "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/SDK/build-tools/28.0.3"
                            ),
                            DownloadInfo(name: "Android SDK Platforms",
                                         url: URL(string: "https://dl.google.com/android/repository/platform-28_r06.zip")!,
                                         version: "28",
                                         encompassing: nil,
                                         installedSize: 121,
                                         downloadSize: 60.6,
                                         renameFrom: "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/SDK/platforms/android-9",
                                         renameTo: "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/SDK/platforms/android-28"
                            ),
                            DownloadInfo(name: "Android NDK 16b",
                                         url: URL(string: "https://dl.google.com/android/repository/android-ndk-r16b-darwin-x86_64.zip")!,
                                         version: "r16b",
                                         encompassing: nil,
                                         installedSize: 2700,
                                         downloadSize: 770,
                                         renameFrom: "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/NDK/android-ndk-r16b",
                                         renameTo: "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/NDK"
                            ),
                            DownloadInfo(name: "Android NDK 19",
                                         url: URL(string: "https://dl.google.com/android/repository/android-ndk-r19-darwin-x86_64.zip")!,
                                         version: "r19",
                                         encompassing: nil,
                                         installedSize: 2700,
                                         downloadSize: 770,
                                         renameFrom: "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/NDK/android-ndk-r19",
                                         renameTo: "{UNITY_PATH}/PlaybackEngines/AndroidPlayer/NDK"
                            )
                         ],
                         installedSize: 174,
                         downloadSize: 148,
                         renameFrom: nil,
                         renameTo: nil
            )
        ]
    }
    
    static var androidOpenJDKInfo: DownloadInfo {
        return DownloadInfo(name: "Android Open JDK",
                            url: URL(string: "http://download.unity3d.com/download_unity/open-jdk/open-jdk-mac-x64/jdk8u172-b11_4be8440cc514099cfe1b50cbc74128f6955cd90fd5afe15ea7be60f832de67b4.zip")!,
                            version: "8u172-b11",
                            encompassing: nil,
                            installedSize: 72.7,
                            downloadSize: 165,
                            renameFrom: nil,
                            renameTo: nil
        )
    }
    
    static func getDestination(component: UnityModule) -> String? {
        switch component {
        case .android: return "{UNITY_PATH}/PlaybackEngines/AndroidPlayer"
        default: return nil
        }
    }
}

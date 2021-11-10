import Foundation

struct HubDataWrapper: Codable {
    var uuid: String?
    
    var hubLocation: String?
    var installLocation: String?
    var projectLocation: String?
    
    var customInstallLocations: [String]?
    
    var useEmoji: Bool?
    var usePins: Bool?
    var showLocation: Bool?
    var showFileSize: Bool?
    var useSmallSidebar: Bool?
    var showSidebarCount: Bool?

    var defaultVersion: UnityVersionWrapper?
    
    var projects: [ProjectDataWrapper]?
    var versions: [UnityVersionWrapper]?
    
    init(original: HubData) {
        uuid = original.uuid
        
        hubLocation = original.hubLocation
        installLocation = original.installLocation
        projectLocation = original.projectLocation
        
        customInstallLocations = original.customInstallLocations
        
        useEmoji = original.useEmoji
        usePins = original.usePins
        showLocation = original.showLocation
        showFileSize = original.showFileSize
        useSmallSidebar = original.useSmallSidebar
        showSidebarCount = original.showSidebarCount
        
        defaultVersion = UnityVersionWrapper(original: original.defaultVersion)
        
        projects = ProjectDataWrapper.wrap(original.projects)
        versions = UnityVersionWrapper.wrap(original.versions)
    }
        
    init(data: Data) {
        do {
            self = try JSONDecoder().decode(HubDataWrapper.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func unwrap() -> HubData {
        var result = HubData()
        
        result.uuid = uuid ?? UUID().uuidString
        
        result.hubLocation = hubLocation ?? #"/Applications/Unity\ Hub.app"#
        result.installLocation = installLocation ?? #"/Applications/Unity/Hub/Editor"#
        result.projectLocation = projectLocation ?? #"~"#

        result.customInstallLocations = customInstallLocations ?? []

        result.useEmoji = useEmoji ?? true
        result.usePins = usePins ?? true
        result.showLocation = showLocation ?? false
        result.showFileSize = showFileSize ?? false
        result.useSmallSidebar = useSmallSidebar ?? false
        result.showSidebarCount = showSidebarCount ?? true
        
        result.defaultVersion = defaultVersion?.unwrap() ?? .null
        
        result.projects = projects?.map { $0.unwrap() } ?? []
        result.versions = versions?.map { $0.unwrap() } ?? []

        return result
    }
    
    static func wrap(_ original: HubData) {
        let wrapper = HubDataWrapper(original: original)
            
        do {
            try wrapper.asData()?.write(to: HubData.fileLocation)
        } catch {
            print("Couldn't save hub data\n\(error.localizedDescription)")
        }
    }
    
    func asData() -> Data? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(self)
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}

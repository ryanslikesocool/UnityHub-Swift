import Foundation

struct ModuleJSON: Codable {
    var id: String
    var name: String
    var description: String
    var downloadUrl: String
    var installedSize: Int
    var downloadSize: Int
    var visible: Bool
    var selected: Bool
    var destination: String?
    var checksum: String?
    
    var fileSize: String? = ""
    var module: UnityModule { return UnityModule(rawValue: id) ?? .none }
    
    var path: String? { return module.getInstallPath() }
    
    init() {
        self.id = ""
        self.name = ""
        self.description = ""
        self.downloadUrl = ""
        self.installedSize = 0
        self.downloadSize = 0
        self.visible = false
        self.selected = false
        self.destination = nil
        self.checksum = nil
    }
    
    static func getModuleData(_ unityPath: String) -> [ModuleJSON] {
        if unityPath == "" { return [] }
        do {
            let url = URL(fileURLWithPath: "\(unityPath)/modules.json")
            let data: Data = try Data(contentsOf: url)
            return try! JSONDecoder().decode([ModuleJSON].self, from: data).filter { $0.selected && (UnityModule(rawValue: $0.id) != Optional.none) }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func removeModule(_ version: UnityVersion, moduleType: UnityModule, settings: AppState) {
        if let index = version.modules.firstIndex(where: { $0.id == moduleType.rawValue }) {
            var module = version.modules[index]
            if module.selected, let installPath = moduleType.getInstallPath() {
                DispatchQueue.global(qos: .background).async {
                    _ = shell("rm -rf \(version.path)\(installPath)")
                    
                    DispatchQueue.main.async {
                        module.selected = false
                        settings.setModule(version, module)
                        ModuleJSON.saveModules(version)
                    }
                }
            }
        }
    }
    
    static func removeModule(_ version: UnityVersion, module: ModuleJSON, settings: AppState) {
        removeModule(version, moduleType: module.module, settings: settings)
    }
    
    static func saveModules(_ version: UnityVersion) {
        do {
            let toSave = try JSONEncoder().encode(version.modules)
            try toSave.write(to: URL(fileURLWithPath: "\(version.path)/modules.json"))
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ModuleJSON: Hashable, Identifiable {}

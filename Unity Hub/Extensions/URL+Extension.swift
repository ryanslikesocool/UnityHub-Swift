import AppKit
import Foundation

extension URL {
    func isDirectoryAndReachable() throws -> Bool {
        guard try resourceValues(forKeys: [.isDirectoryKey]).isDirectory == true else {
            return false
        }
        return try checkResourceIsReachable()
    }

    func directoryTotalAllocatedSize(includingSubfolders: Bool = false) throws -> Int? {
        guard try isDirectoryAndReachable() else { return nil }
        if includingSubfolders {
            guard let urls = FileManager.default.enumerator(at: self, includingPropertiesForKeys: nil)?.allObjects as? [URL] else { return nil }

            return try urls.lazy.reduce(0) {
                (try $1.resourceValues(forKeys: [.totalFileAllocatedSizeKey]).totalFileAllocatedSize ?? 0) + $0
            }
        }
        return try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil).lazy.reduce(0) {
            (try $1.resourceValues(forKeys: [.totalFileAllocatedSizeKey])
                .totalFileAllocatedSize ?? 0) + $0
        }
    }

    func sizeOnDisk() throws -> String? {
        guard let size = try directoryTotalAllocatedSize(includingSubfolders: true) else { return nil }
        URL.byteCountFormatter.countStyle = .file
        guard let byteCount = URL.byteCountFormatter.string(for: size) else { return nil }
        return byteCount
    }

    static let byteCountFormatter = ByteCountFormatter()
}

extension URL {
    func showInFinder() {
        if hasDirectoryPath {
            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: path)
        } else {
            showInFinderAndSelectLastComponent(of: self)
        }
    }

    fileprivate func showInFinderAndSelectLastComponent(of url: URL) {
        NSWorkspace.shared.activateFileViewerSelecting([url])
    }

    static var homeDirectory: URL { FileManager.default.homeDirectoryForCurrentUser }
}

extension URL: Unwrappable {
    init(unwrap any: Any?, _ default: URL) {
        if let str = any as? String {
            self = URL(string: str) ?? `default`
        } else {
            self = any as? URL ?? `default`
        }
    }
}

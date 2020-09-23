//
//  NSOpenPanel.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import Foundation
import AppKit

extension NSOpenPanel {
    static func openFolder(completion: @escaping (_ result: Result<String, Error>) -> ()) {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.begin { result in
            if result == .OK, let url = panel.urls.first {
                completion(.success(url.path))
            } else {
                completion(.failure(
                    NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get folder location"])
                ))
            }
        }
    }
}

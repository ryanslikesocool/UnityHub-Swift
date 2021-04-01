//
//  Array+Extension.swift
//  MessagingApp
//
//  Created by Ryan Boyer on 3/30/21.
//

import Foundation

extension Array where Element: Equatable {
    mutating func removeElement(_ element: Element) {
        if let index = self.firstIndex(of: element) {
            self.remove(at: index)
        }
    }
    
    mutating func setElement(_ element: Element, where predicate: (Element) -> Bool) {
        if let index = self.firstIndex(where: predicate) {
            self[index] = element
        }
    }
}

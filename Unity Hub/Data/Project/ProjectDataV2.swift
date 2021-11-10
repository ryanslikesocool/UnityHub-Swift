import Foundation

struct ProjectDataV2: PlistDictionary {
	static let empty = ProjectDataV2("")
	
	var path: String
	var name: String
	var version: UnityVersion
	var emoji: String
	var pinned: Bool
}

extension ProjectDataV2 {
	init(dictionary: [String : Any]) {
		<#code#>
	}
	
	func saveToDictionary() -> [String : Any] {
		<#code#>
	}
}

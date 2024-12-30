import UnityHubStorageSettings

extension SidebarDisplay {
	var viewStyle: AnySidebarStyle {
		switch self {
			case .standard: AnySidebarStyle(.default)
			case .compact: AnySidebarStyle(.compact)
		}
	}

	var width: Double {
		switch self {
			case .standard: 160
			case .compact: 91
		}
	}
}

import SwiftUI

final class InstallationsModel: ObservableObject {
	@Published
	public var state: InstallationsModelState

	@Published
	public var search: SearchModel

	public init() {
		state = .default
		search = SearchModel()
	}
}

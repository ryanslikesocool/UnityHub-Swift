import Foundation

extension URL {
	static let acknowledgements = Acknowledgements.self

	enum Acknowledgements {
		static let unity: URL! = URL(string: "https://unity.com")
		static let ryanBoyer: URL! = URL(string: "https://ryanjboyer.com")
		static let developedWithLove: URL! = URL(string: "https://developedwith.love")

		static let moreWindows: URL! = URL(string: "https://github.com/ryanslikesocool/MoreWindows")
		static let userIcon: URL! = URL(string: "https://github.com/ryanslikesocool/UserIcon")
	}
}
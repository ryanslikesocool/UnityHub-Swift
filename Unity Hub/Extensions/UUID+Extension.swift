import Foundation

extension UUID: Unwrappable {
    init(unwrap any: Any?, _ default: UUID) {
        if let str = any as? String {
            self = UUID(uuidString: str) ?? `default`
        } else {
            self = any as? UUID ?? `default`
        }
    }
}

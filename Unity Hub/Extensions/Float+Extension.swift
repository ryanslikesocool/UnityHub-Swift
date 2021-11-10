extension Float: Unwrappable {
    init(unwrap any: Any?, _ default: Float = 0) {
        self = any as? Float ?? `default`
    }
}

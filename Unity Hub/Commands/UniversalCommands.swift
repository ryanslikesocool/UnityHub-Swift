import SwiftUI

struct UniversalCommands: Commands {
    @CommandsBuilder var body: some Commands {
        CommandGroup(replacing: .newItem) { }
    }
}

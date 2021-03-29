//
//  AdvancedProjectSettingsSheet.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 10/1/20.
//

import SwiftUI

struct AdvancedProjectSettingsSheet: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            Button("Cancel", action: closeMenu)
                .padding(8)
            Spacer()
            HStack {
                Spacer()
                Button("Save", action: { })
                    .padding(8)
            }
        }
        .frame(width: 256, height: 256)
    }
    
    func closeMenu() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct AdvancedProjectSettingsSheet_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedProjectSettingsSheet()
    }
}

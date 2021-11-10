import SwiftUI

struct SettingsView: View {
	@EnvironmentObject var settings: AppSettings

    var body: some View {
        TabView {
			SettingsView_General(settings: $settings.general)
        }
    }
}

extension SettingsView {
    @ViewBuilder static func smallLabel(_ text: String) -> some View {
        Text(text)
            .padding(.trailing, 32)
    }

    @ViewBuilder static func maxLabel(_ text: String) -> some View {
        Text(text)
        Spacer()
    }

    @ViewBuilder static func wideToggle(_ label: String, isOn: Binding<Bool>) -> some View {
        HStack {
            maxLabel(label)
            Toggle("", isOn: isOn)
        }
    }

    @ViewBuilder static func widePicker<T: Hashable, Content: View>(_ label: String, selection: Binding<T>, @ViewBuilder content: @escaping () -> Content) -> some View {
        HStack {
            maxLabel(label)
            Picker("", selection: selection) {
                content()
            }
            .frame(width: 160)
        }
    }

    @ViewBuilder static func wideSlider(_ label: String, value: Binding<Float>, in range: ClosedRange<Float>) -> some View {
        HStack {
            maxLabel(label)
            Slider(value: value, in: range, step: Float(1), label: {}, minimumValueLabel: { Text("\(Int(range.lowerBound))") }, maximumValueLabel: { Text("\(Int(range.upperBound))") })
                .frame(width: 160)
        }
    }
}

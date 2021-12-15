import SwiftUI

extension SettingsView {
    struct SmallLabel: View {
        let text: String

        init(_ text: String) {
            self.text = text
        }

        var body: some View {
            Text(text)
                .padding(.trailing, 32)
        }
    }

    struct MaxLabel: View {
        let text: String

        init(_ text: String) {
            self.text = text
        }

        var body: some View {
            Text(text)
            Spacer()
        }
    }

    struct WideToggle: View {
        let label: String
        @Binding var isOn: Bool

        init(_ label: String, isOn: Binding<Bool>) {
            self.label = label
            _isOn = isOn
        }

        var body: some View {
            HStack {
                Text(label)
                Spacer()
                Toggle("", isOn: $isOn)
                    .labelsHidden()
            }
        }
    }

    struct WidePicker<T: Hashable, Content: View>: View {
        let label: String
        @Binding var selection: T
        let content: () -> Content

        init(_ label: String, selection: Binding<T>, @ViewBuilder content: @escaping () -> Content) {
            self.label = label
            _selection = selection
            self.content = content
        }

        var body: some View {
            HStack {
                Text(label)
                Spacer()
                Picker("", selection: $selection) {
                    content()
                }
                .frame(width: 160)
            }
        }
    }

    struct WideSlider: View {
        let label: String
        @Binding var value: Float
        let range: ClosedRange<Float>

        init(_ label: String, value: Binding<Float>, in range: ClosedRange<Float>) {
            self.label = label
            _value = value
            self.range = range
        }

        var body: some View {
            HStack {
                Text(label)
                Spacer()
                Slider(value: $value, in: range, step: Float(1), label: {}, minimumValueLabel: { Text("\(Int(range.lowerBound))") }, maximumValueLabel: { Text("\(Int(range.upperBound))") })
                    .frame(width: 160)
            }
        }
    }

    internal struct WideButton: View {
        let label: String
        let action: () -> Void

        init(_ label: String, action: @escaping () -> Void) {
            self.label = label
            self.action = action
        }

        var body: some View {
            HStack {
                Spacer()

                Button(label) { action() }
                    .buttonStyle(.bordered)
            }
        }
    }

    internal struct SidebarItem: View {
        let label: String
        let image: String

        var body: some View {
            HStack {
                Image(image)
                Text(label)
            }
            .frame(height: 32)
            .font(.system(size: 13, weight: .semibold))
            .tag(label)
        }
    }
}

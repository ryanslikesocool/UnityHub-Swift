//
//  Widget.swift
//  Widget
//
//  Created by Ryan Boyer on 10/6/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WidgetEntry) -> ()) {
        let entry = WidgetEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WidgetEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = WidgetEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct WidgetEntryView : View {
    @EnvironmentObject var settings: HubSettings
    var entry: Provider.Entry

    var body: some View {
        let rows = [
            GridItem(.adaptive(minimum: 192, maximum: 512))
        ]
        
        LazyHGrid(rows: rows) {
            ForEach(0 ..< min(settings.projects.count, 4)) { i in
                let project = settings.projects[i]
                SimpleProjectButton(path: project.0, project: project.1, version: project.2)
            }
        }
    }
}

@main
struct UnityHubWidget: Widget {
    let settings: HubSettings = HubSettings()
    let kind: String = "Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
                .environmentObject(settings)
                .onAppear(perform: { HubSettings.getAllProjects(settings: settings) })
        }
        .configurationDisplayName("Recent Projects")
        .description("Quickly open Unity projects.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

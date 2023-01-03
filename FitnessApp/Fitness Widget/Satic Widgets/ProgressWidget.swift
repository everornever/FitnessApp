//
//  Fitness_Widget.swift
//  Fitness Widget
//
//  Created by Leon Kling on 01.01.23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    // Placeholder
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    // get working dummy for preview
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    // timeline for the data
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let midnight = Calendar.current.startOfDay(for: Date())
        let nextMidnight = Calendar.current.date(byAdding: .day, value: 1, to: midnight)!
        let entries = [SimpleEntry(date: midnight)]
        let timeline = Timeline(entries: entries, policy: .after(nextMidnight))
        completion(timeline)
    }
}

// data entry, needs to have a date
struct SimpleEntry: TimelineEntry {
    let date: Date
}

// Main View
struct MainWidgetView : View {
    
    // what widget family is displayed
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    // entry (needed?)
    var entry: SimpleEntry

    @ViewBuilder // @ViewBuilder because the type of view it uses varies.  (is that still needed ?)
    var body: some View {
        // switch case for different widget sizes but same information
        switch family {
            //case .systemSmall: GoalWidget(entry: entry)
            case .systemMedium: CurrentWeekView(workouts: readData())
            default: CurrentWeekView(workouts: readData()) // show empty view in future ?
        }
    }
    
    // read user defaults
    private func readData() -> [Workout] {
        var savedWorkouts: [Workout]
        if let savedItems = UserDefaults(suiteName: "group.BETA-CODE.FitnessApp")!.data(forKey: "SavedWorkouts") {
            if let decodedItems = try? JSONDecoder().decode([Workout].self, from: savedItems) {
                savedWorkouts = decodedItems
                return savedWorkouts
            }
        }
        savedWorkouts = []
        return savedWorkouts
    }
}

// Widget creation
struct ProgressWidget: Widget {
    
    let kind: String = "ProgressWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MainWidgetView(entry: entry)
        }
        .configurationDisplayName("Progress Widgets")
        .description("Gives you an overview of your progress")
        .supportedFamilies([.systemMedium])
        
    }
}

// MARK: - Preview
struct Fitness_Widget_Previews: PreviewProvider {
    static var previews: some View {
        MainWidgetView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

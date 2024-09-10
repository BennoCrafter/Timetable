import Foundation
import SwiftUI

// Event Template
struct EventTemplate: Codable {
    let name: String
    let color: String // hex code
    let occurrences: [Occurrence]
}

struct Occurrence: Codable {
    let interval: Interval
    let id: UUID
    let startTime: Time
    let endTime: Time
    let day: Day
}

struct Event: Codable {
    let name: String
    let color: String // hex code
    let eventId: UUID
    let occurrenceId: UUID
    let startDate: Date
    let endDate: Date
}


struct Time: Codable {
    var hours: Int
    var minutes: Int
}
// Day Model
enum Day: String, Codable, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    
    var calendarWeekday: Int {
        switch self {
        case .monday: return 2
        case .tuesday: return 3
        case .wednesday: return 4
        case .thursday: return 5
        case .friday: return 6
        case .saturday: return 7
        case .sunday: return 1
        }
    }
}

enum Interval: String, Codable, CaseIterable, Identifiable {
 
    var id: String {self.rawValue }
    case daily, weekly, monthly
}
// Color Palette Model
struct ColorPalette: Codable {
    let name: String
    let colors: [String] // Store as hex strings
}

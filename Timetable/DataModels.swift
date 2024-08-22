import Foundation
import SwiftUI

// Timetable Entry Model
struct Entry: Identifiable {
    let id: UUID
    let day: Day
    let startTime: String
    let endTime: String
    let subject: Subject
}

struct EntryDTO: Codable, Identifiable{
    let id: UUID
    let day: Day
    let startTime: String
    let endTime: String
    let subjectId: UUID
}

// Subject Model
struct Subject: Codable, Identifiable {
    let id: UUID
    let name: String
    let color: String // Store as hex string
}

// Day Model
enum Day: String, Codable, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

// Color Palette Model
struct ColorPalette: Codable {
    let name: String
    let colors: [String] // Store as hex strings
}

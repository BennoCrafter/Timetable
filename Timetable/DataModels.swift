import Foundation

struct Event: Codable {
    let name: String
    let description: String
    let duration: TimeInterval
}

struct Lesson: Codable {
    let name: String
    let timeBegin: String
    let timeEnd: String
    var events: [Event]?
}
import Foundation

class DataManager {
    private let timetableKey = "timetable"
    var timetable: [String: [Lesson]] = [:]
    
    init() {
        loadTimetable()
    }
    
    // Save lessons for a specific day
    func saveLessons(forDay day: String, lessons: [Lesson]) {
        timetable[day] = lessons
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(timetable) {
            UserDefaults.standard.set(encoded, forKey: timetableKey)
        }
    }
    
    // Load lessons for a specific day
    func loadLessons(forDay day: String) -> [Lesson]? {
        return timetable[day]
    }
    
    // Private method to load entire timetable from UserDefaults
    private func loadTimetable() {
        if let savedTimetable = UserDefaults.standard.data(forKey: timetableKey) {
            let decoder = JSONDecoder()
            if let loadedTimetable = try? decoder.decode([String: [Lesson]].self, from: savedTimetable) {
                timetable = loadedTimetable
            }
        }
    }
}

import Foundation


// ["#61a8ec", "#ff6347", "#32cd32", "#ffd700"]

class DataManager {
    private let timetableKey = "timetable"
    private let colorOptionsKey = "colorOptions"
    var timetable: [String: [Lesson]] = [:]
    var colorOptions: [String] = []
    
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
    
    private func loadColorOptions() {
        if let savedColorOptions = UserDefaults.standard.data(forKey: colorOptionsKey) {
            let decoder = JSONDecoder()
            if let loadedColorOptions = try? decoder.decode([String].self, from: savedColorOptions) {
                colorOptions = loadedColorOptions
            }
        }
    }
    
}

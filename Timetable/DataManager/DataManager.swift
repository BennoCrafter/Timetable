import Foundation

class DataManager {
    
    // Function to save example data to UserDefaults if no data exists
    private func saveExampleDataIfNeeded() {
        guard UserDefaults.standard.dictionary(forKey: "data") == nil else {
            return // Data already exists, no need to save example data
        }
        UserDefaults.standard.set(exampleData, forKey: "data")
    }
    
    private func saveData(){
        UserDefaults.standard.set(exampleData, forKey: "data")
    }
    
    // Function to load data from UserDefaults
    private func loadData() -> [String: Any]? {
        saveData()
        return UserDefaults.standard.dictionary(forKey: "data")
    }
    
    // Function to get lessons for a specific day
    func getLessons(forDay day: String) -> [[String: String]]? {
        if let data = loadData(), let timetableData = data["timetableData"] as? [String: [[String: String]]] {
            return timetableData[day]
        } else if let exampleTimetableData = exampleData["timetableData"] as? [String: [[String: String]]] {
            return exampleTimetableData[day]
        } else {
            return nil
        }
    }
    
    // Function to get color options
    func getColorOptions() -> [String]? {
        if let data = loadData(), let colorOptions = data["colorOptions"] as? [String] {
            return colorOptions
        } else if let exampleColorOptions = exampleData["colorOptions"] as? [String] {
            return exampleColorOptions
        } else {
            return nil
        }
    }
    
    // Function to add a new lesson to the timetable data for a specific day
    func addLessonToTimetable(forDay day: String, newLesson: [String: String]) {
        if var data = loadData(), var timetableData = data["timetableData"] as? [String: [[String: String]]] {
            if var dayLessons = timetableData[day] {
                dayLessons.append(newLesson)
                timetableData[day] = dayLessons
                data["timetableData"] = timetableData
                UserDefaults.standard.set(data, forKey: "data")
                print("Lesson added successfully for \(day).")
            } else {
                print("No timetable data found for \(day).")
            }
        } else {
            print("Failed to load data from UserDefaults.")
        }
    }
    
    // Function to set the lessons of a specific day in the timetable data
    func setLessonsForDay(day: String, lessons: [[String: String]]) {
        if var data = loadData(), var timetableData = data["timetableData"] as? [String: [[String: String]]] {
            timetableData[day] = lessons
            data["timetableData"] = timetableData
            UserDefaults.standard.set(data, forKey: "data")
            print("Lessons set successfully for \(day).")
        } else {
            print("Failed to load data from UserDefaults.")
        }
    }
    
    // Example data
    private let exampleData: [String: Any] = [
        "timetableData": [
            "monday": [
                ["lesson": "Math", "startTime": "08:00", "endTime": "09:00", "color": "#61a8ec"],
                ["lesson": "Science", "startTime": "09:15", "endTime": "10:15", "color": "#32cd32"]
            ],
            "tuesday": [
                ["lesson": "History", "startTime": "08:30", "endTime": "09:30", "color": "#ff6347"],
                ["lesson": "English", "startTime": "09:45", "endTime": "10:45", "color": "#ffd700"]
            ],
            // Add data for other days as needed
        ],
        "colorOptions": ["#61a8ec", "#ff6347", "#32cd32", "#ffd700"]
    ]
}


import Foundation

func generateDayNames(from startDate: Date, to endDate: Date) -> [(dayName: String, date: Date)] {
    var dayNames: [(dayName: String, date: Date)] = []
    var currentDate = startDate
    
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE" // Full day name (e.g., "Monday")
    
    while currentDate <= endDate {
        let dayName = dateFormatter.string(from: currentDate)
        dayNames.append((dayName: dayName, date: currentDate))
        
        // Move to the next day
        if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
            currentDate = nextDate
        } else {
            break
        }
    }
    
    return dayNames
}

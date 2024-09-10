import Foundation

class TimetableManager {
    var events: [Event]
    var timeZone: TimeZone
    
    init(events: [Event] = [], timeZone: TimeZone = TimeZone.current) {
        self.events = events
        self.timeZone = timeZone
    }
    
    public func getEvents(from startDate: Date, to endDate: Date) -> [Event] {
        var filteredEvents: [Event] = []
        let calendar = Calendar.current
        
        for event in self.events {
            // Check if the event starts before the start date
            if calendar.compare(event.startDate, to: startDate, toGranularity: .day) == .orderedAscending {
                continue
            }

            // Check if the event starts after the end date
            if calendar.compare(event.startDate, to: endDate, toGranularity: .day) == .orderedDescending {
                break
            }

            // Check if the event overlaps with the range
            if calendar.compare(event.endDate, to: startDate, toGranularity: .day) != .orderedAscending &&
                calendar.compare(event.startDate, to: endDate, toGranularity: .day) != .orderedDescending {
                filteredEvents.append(event)
            }
        }

        
        return filteredEvents
    }

    private func insertEvent(event: Event) {
        for (i, sortedEvent) in self.events.enumerated(){
            if event.startDate < sortedEvent.startDate{
                self.events.insert(event, at: i)
                return
            }
        }
        self.events.append(event)

    }
    
    func generateEvents(from template: EventTemplate, at startDate: Date, upTo endDate: Date) {
        for occurrence in template.occurrences {
            var currentDate = startDate
            while currentDate <= endDate {
                let dates = generateDates(from: occurrence, startingFrom: currentDate)
                for date in dates {
                    guard date.startDate <= endDate else { continue }
                    
                    let event = Event(
                        name: template.name,
                        color: template.color,
                        eventId: UUID(),
                        occurrenceId: occurrence.id,
                        startDate: date.startDate,
                        endDate: date.endDate
                    )
                    insertEvent(event: event)
                }
                // Move to the next interval
                currentDate = moveToNextInterval(from: currentDate, interval: occurrence.interval)
            }
        }
    }
    
    func generateEvents(from_templates templates: [EventTemplate],  at startDate: Date, upTo endDate: Date){
        for template in templates {
            self.generateEvents(from: template, at: startDate, upTo: endDate)
        }
    }
    
    private func generateDates(from occurrence: Occurrence, startingFrom startDate: Date) -> [(startDate: Date, endDate: Date)] {
        var dates: [(startDate: Date, endDate: Date)] = []
        let calendar = Calendar.current
        
        // Compute the weekday components
        let weekdayComponents = DateComponents(weekday: occurrence.day.calendarWeekday)
        
        // Find the next occurrence of the specified day
        guard let nextDay = calendar.nextDate(after: startDate, matching: weekdayComponents, matchingPolicy: .nextTime) else { return [] }
        
        // Compute the start and end dates
        var startDateComponents = calendar.dateComponents([.year, .month, .day], from: nextDay)
        startDateComponents.hour = occurrence.startTime.hours
        startDateComponents.minute = occurrence.startTime.minutes
        guard let eventStartDate = calendar.date(from: startDateComponents) else { return [] }
        
        var endDateComponents = calendar.dateComponents([.year, .month, .day], from: nextDay)
        endDateComponents.hour = occurrence.endTime.hours
        endDateComponents.minute = occurrence.endTime.minutes
        guard let eventEndDate = calendar.date(from: endDateComponents) else { return [] }
        
        if eventStartDate >= startDate {
            dates.append((startDate: eventStartDate, endDate: eventEndDate))
        }
        
        return dates
    }
    
    private func moveToNextInterval(from date: Date, interval: Interval) -> Date {
        let calendar = Calendar.current
        
        switch interval {
        case .daily:
            return calendar.date(byAdding: .day, value: 1, to: date) ?? date
        case .weekly:
            return calendar.date(byAdding: .weekOfYear, value: 1, to: date) ?? date
        case .monthly:
            return calendar.date(byAdding: .month, value: 1, to: date) ?? date
        }
    }
    
    public func printEvents() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = self.timeZone
        
        for event in self.events {
            print("Event: \(event.name) starts at \(dateFormatter.string(from: event.startDate)) and ends at \(dateFormatter.string(from: event.endDate))")
        }
    }
}

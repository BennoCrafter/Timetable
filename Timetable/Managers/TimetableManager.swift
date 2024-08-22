import Foundation

class TimetableManager{
    var entries: [Entry]
    
    init(entries: [Entry]){
        self.entries = entries
    }
    
    public func getEntries(forDay day: Day) -> [Entry]{
        return self.entries.filter {$0.day == day}
    }
}

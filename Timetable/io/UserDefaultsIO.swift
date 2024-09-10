import Foundation


class UserDefaultsIO {
    
    private let userDefaults: UserDefaults
    
    // Initialize with the standard UserDefaults instance or a custom one for testing
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public func saveEvents(events: [Event]) {
        do{
            let eventsData = try JSONEncoder().encode(events)
            userDefaults.set(eventsData, forKey: "eventsData")
        }catch {
            print("Failed to store eventTemplatesData in UserDefaults: \(error)")
        }
    }
    
    public func storeEventTemplates(eventTemplates: [EventTemplate]) {
        do{
            let eventTemplatesData = try JSONEncoder().encode(eventTemplates)
            userDefaults.set(eventTemplatesData, forKey: "eventTemplates")
        }catch {
            print("Failed to store eventTemplatesData in UserDefaults: \(error)")
        }
    }

    public func loadEvents() -> [Event] {
        guard let data = userDefaults.data(forKey: "eventsData") else {
            return []
        }

        do {
            let events = try JSONDecoder().decode([Event].self, from: data)
            return events
        } catch {
            print("Failed to decode events object: \(error)") // Updated error message
            return []
        }
    }

    
    // MARK: - Utility Methods
    
    func removeObject(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    func clearAll() {
        if let appDomain = Bundle.main.bundleIdentifier {
            userDefaults.removePersistentDomain(forName: appDomain)
        }
    }
}

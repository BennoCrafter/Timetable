import Foundation


class UserDefaultsIO {
    
    private let userDefaults: UserDefaults
    
    // Initialize with the standard UserDefaults instance or a custom one for testing
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    private func convertEntryDTOToEntry(entryDTO: EntryDTO, subjects: [Subject]) -> Entry{
        let neededSubject = subjects.first { $0.id == entryDTO.subjectId }!
        return Entry(id: entryDTO.id, day: entryDTO.day, startTime: entryDTO.startTime, endTime: entryDTO.endTime, subject: neededSubject)
        
    }
    
    private func convertEntryToEntryDTO(entry: Entry) -> EntryDTO{
        let entryDTO = EntryDTO(id: entry.id, day: entry.day, startTime: entry.startTime, endTime: entry.endTime, subjectId: entry.subject.id)
        return entryDTO
    }
    
    
    public func storeEntries(entries: [Entry]) -> Void{
        var entriesDTO: [EntryDTO] = []
        for entry in entries{
            entriesDTO.append(convertEntryToEntryDTO(entry: entry))
        }
        do{
            let entriesData = try JSONEncoder().encode(entriesDTO)
            userDefaults.set(entriesData, forKey: "timetableEntries")
        }catch {
            print("Failed to store entries in UserDefaults: \(error)")
        }
    }
    
    public func loadEntries() -> [Entry] {
        guard let data = userDefaults.data(forKey: "timetableEntries") else {
            return []
        }

        do {
            let entriesDTO = try JSONDecoder().decode([EntryDTO].self, from: data)
            var entries: [Entry] = [] // Initialize the array here

            for entryDTO in entriesDTO {
                let entry = convertEntryDTOToEntry(entryDTO: entryDTO, subjects: loadSubjects())
                entries.append(entry) // Append the converted entry to the array
            }

            return entries
        } catch {
            print("Failed to decode entries object: \(error)")
            return []
        }
    }
    
    public func storeSubjects(subjects: [Subject]) {
        do{
            let subjectsData = try JSONEncoder().encode(subjects)
            userDefaults.set(subjectsData, forKey: "timetableSubjects")
        }catch {
            print("Failed to store subjects in UserDefaults: \(error)")
        }
    }

    private func loadSubjects() -> [Subject] {
        guard let data = userDefaults.data(forKey: "timetableSubjects") else {
            return []
        }

        do {
            let subjects = try JSONDecoder().decode([Subject].self, from: data)
            return subjects
        } catch {
            print("Failed to decode subjects object: \(error)") // Updated error message
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

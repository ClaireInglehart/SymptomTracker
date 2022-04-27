//
//  DataService.swift
//  SymptomTracker
//
//  Created on 2/10/22.
//

import Foundation

class DataService {
    static let shared = DataService()
    
    private var users: [User] = []
    private let dataKeyName = "data_v3"
    public var currentUser: User?
        
    init() {
        self.users = self.load()
    }

    public func userExists(withEmail email: String) -> Bool {
        return self.users.first(where: { ($0.email == email) }) != nil
    }

    public func getUser(forEmail email: String, forPasswordDigest passwordDigest: String) -> User? {
        return self.users.first(where: { ($0.email == email) && ($0.passwordDigest == passwordDigest) })
    }

    private func isValidUser(_ user: User) -> Bool {
        return self.getUser(forEmail: user.email, forPasswordDigest: user.passwordDigest) != nil
    }

    public func addUser(withEmail email: String, withPasswordDigest passwordDigest: String) -> User? {
        let newUser = User(email: email, passwordDigest: passwordDigest)
        self.users.append(newUser)
        self.save()
        return newUser
    }
    
    public func getSymptoms(forUser user: User) -> [Symptom] {
        if self.isValidUser(user) {
            return user.symptoms
        } else {
            return []
        }
    }
    
    public func getCheckins(forUser user: User) -> [Checkin] {
        if self.isValidUser(user) {
            return user.checkins
        } else {
            return []
        }
    }
    
    public func addSymptom(_ symptom: Symptom, forUser user: User) {
        if self.isValidUser(user) {
            user.symptoms.append(symptom)
            save()
        } else {
            print("❌ user not found!")
        }
    }
    
    
    public func addCustomTrigger(_ trigger: CustomTrigger, forSymptom symptom: Symptom) {
        symptom.customTriggers.append(trigger)
        save()
    }

    public func addAppleHealthTrigger(_ trigger: AppleHealthTrigger, forSymptom symptom: Symptom) {
        symptom.appleHealthTriggers.append(trigger)
        save()
    }


    public func getCheckin(forDate date: Date, forUser user: User) -> Checkin? {
        if self.isValidUser(user) {
            return user.checkins.forDate(date)
        } else {
            print("❌ user not found!")
            return nil
        }
    }
    
    public func addCheckin(_ checkIn: Checkin, forUser user: User) {
        if self.isValidUser(user) {
            user.checkins.append(checkIn)
            save()
        } else {
            print("❌ user not found!")
        }
    }
    
    // TODO: deleteSymptom
    // TODO: deleteCheckin
    
    private func load() -> [User] {
        
        if let jsonString = self.loadJSON(dataKeyName),
           let data = jsonString.data(using: .utf8) {
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data)
                return users
            } catch {
                print("Whoops, an error occured while saving: \(error)")
            }

        }
        return []
    }
    
    
    
    private func save() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(users)
            if let jsonString = String(data: data, encoding: .utf8) {
                saveJSON(jsonString: jsonString, key: dataKeyName)
            } else {
                print("Whoops, couldn't convert data to string")
            }
        } catch {
            print("Whoops, an error occured while saving: \(error)")
        }
    }
    
    
    private func saveJSON(jsonString: String, key:String){
        
        print("saveJSON: \(jsonString)")
        UserDefaults.standard.setValue(jsonString, forKey: key)
    }
    
    private func loadJSON(_ key: String) -> String? {
        let jsonString = UserDefaults.standard.string(forKey: key)
        print("loadJSON: \(jsonString ?? "")")
        return jsonString
    }
    
    public func trash() {
        self.users = []
        self.saveJSON(jsonString: "", key: dataKeyName)
        print("🗑 all user accounts deleted")
    }
    
    public func mlTest(forUser user: User) {
        print("🔆🔆🔆 ML Test 🔆🔆🔆")
        // For each symptom:
        // date, <symptom name>, <trigger 1 name>, <trigger 2 name>, ...
        //
        // Generate dummy data for this user for the past week.
        let today = Date()
        let dates = [today.dateBySubtractingDays(6),
                     today.dateBySubtractingDays(5),
                     today.dateBySubtractingDays(4),
                     today.dateBySubtractingDays(3),
                     today.dateBySubtractingDays(2),
                     today.dateBySubtractingDays(1),
                     today]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        for symptom in self.getSymptoms(forUser: user) {
            let fileName = "\(symptom.name).csv"
            var fileLines: [String] = []

            fileLines.append(self.makeHeaderString(forSymptom: symptom))
            print("\(self.makeHeaderString(forSymptom: symptom))")

            for date in dates {
                var values: [String] = []
                values.append(dateFormatter.string(from: date))
                values.append(self.randomSeverity().toString())
                for _ in symptom.customTriggers {
                    values.append("\(self.randomValue(min: 0, max: 20))")
                }
                for _ in symptom.appleHealthTriggers {
                    values.append("\(self.randomValue(min: 0, max: 20))")
                }
                fileLines.append(values.joined(separator: ", "))
                print(values.joined(separator: ", "))
            }
            let stringToSave = fileLines.joined(separator: "\n")
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)

            if let stringData = stringToSave.data(using: .utf8) {
                try? stringData.write(to: path)
            }
            print("\(fileName) data written to:")
            print(path.absoluteString)
        }
        
    }
    
    private func makeHeaderString(forSymptom symptom: Symptom) -> String {
        var headers = ["date", symptom.name]
        for trigger in symptom.customTriggers {
            headers.append(trigger.name)
        }
        for trigger in symptom.appleHealthTriggers {
            headers.append(trigger.name)
        }
        return headers.joined(separator: ", ")
    }
    
    private func randomValue(min: Double, max: Double) -> Double {
        return Double.random(in: min...max)
    }

    private func randomSeverity() -> Severity {
        let rawValue = Int.random(in: 0...4)
        return Severity(rawValue: rawValue)!
    }
}


extension Array where Element: Checkin {

    func forDate(_ date: Date) -> Checkin? {
        for checkin in self {
            if checkin.date.isEqualToDateIgnoringTime(date) {
                return checkin
            }
        }
        return nil
    }

}

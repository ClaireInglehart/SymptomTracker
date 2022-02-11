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
    
    init() {
        self.users = self.load()
    }

    public func getUser(forEmail email: String) -> User? {
        return self.users.first(where: { $0.email == email })
    }
    
    public func addUser(withName name: String, email: String) {
        let newUser = User(name: name, email: email)
        self.users.append(newUser)
        self.save()
    }
    
    public func getSymptoms(forUser user: User) -> [Symptom] {
        if let user = self.users.first(where: { $0.email == user.email }) {
            return user.symptoms
        } else {
            return []
        }
    }
    
    public func getTriggers(forUser user: User) -> [Trigger] {
        if let user = self.users.first(where: { $0.email == user.email }) {
            return user.triggers
        } else {
            return []
        }
    }
    
    public func getCheckins(forUser user: User) -> [Checkin] {
        if let user = self.users.first(where: { $0.email == user.email }) {
            return user.checkins
        } else {
            return []
        }
    }
    
    public func addSymptom(_ symptom: Symptom, forUser user: User) {
        if var user = self.users.first(where: { $0.email == user.email }) {
            user.symptoms.append(symptom)
            save()
        } else {
            print("❌ user not found!")
        }
    }
    
    // TODO: deleteSymptom
    
    public func addTrigger(_ trigger: Trigger, forUser user: User) {
        if var user = self.users.first(where: { $0.email == user.email }) {
            user.triggers.append(trigger)
            save()
        } else {
            print("❌ user not found!")
        }
    }

    // TODO: deleteTrigger

    public func addCheckin(_ checkIn: Checkin, forUser user: User) {
        if var user = self.users.first(where: { $0.email == user.email }) {
            user.checkins.append(checkIn)
            save()
        } else {
            print("❌ user not found!")
        }
    }
    
    // TODO: deleteCheckin
    
    private func load() -> [User] {
        
        if let jsonString = self.loadJSON("data"),
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
                saveJSON(jsonString: jsonString, key: "data")
            } else {
                print("Whoops, couldn't convert data to string")
            }
        } catch {
            print("Whoops, an error occured while saving: \(error)")
        }

    }
    
    
    private func saveJSON(jsonString: String, key:String){
        
        UserDefaults.standard.setValue(jsonString, forKey: key)
    }
    
    private func loadJSON(_ key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
}

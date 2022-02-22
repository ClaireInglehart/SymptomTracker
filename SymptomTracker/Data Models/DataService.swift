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
    private let dataKeyName = "data_v1"
    public var currentUser: User?
        
    init() {
        self.users = self.load()
    }

    public func getUser(forEmail email: String) -> User? {
        return self.users.first(where: { $0.email == email })
    }

    public func isValidUser(_ user: User) -> Bool {
        return self.getUser(forEmail: user.email) != nil
    }

    public func addUser(withName name: String, email: String) -> User? {
        let newUser = User(name: name, email: email)
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
    
    // TODO: deleteSymptom
    
    public func addTrigger(_ trigger: Trigger, forSymptom symptom: Symptom) {
        symptom.triggers.append(trigger)
        save()
    }

    // TODO: deleteTrigger

    public func addCheckin(_ checkIn: Checkin, forUser user: User) {
        if self.isValidUser(user) {
            user.checkins.append(checkIn)
            save()
        } else {
            print("❌ user not found!")
        }
    }
    
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
}

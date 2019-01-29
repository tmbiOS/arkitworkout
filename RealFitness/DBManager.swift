//
//  DBManager.swift
//  RealFitness
//
//  Created by Игорь on 29/01/2019.
//  Copyright © 2019 Satori Worldwide, Inc. All rights reserved.
//

import Firebase

class DBManager: NSObject {
  
  struct Const {
    static let measurement = "measurement"
    static let users = "users"
  }
  
  //  static var ref: DatabaseReference!
  
  @objc static func initDB() {
    FirebaseApp.configure()
  }
  
  @objc static func observe(completion: @escaping (Message?) -> Void) {
    //    ref.child("users").childByAutoId().setValue(["name": "Igor"])
    let ref = Database.database().reference()
    ref.child(Const.measurement).observe(.childAdded) { (snapshot) in
      guard let json = snapshot.value as? [String: Any],
        let message = Message(json: json)
        else { return }
      if message.messages.first?.userid == UserDefaults.standard.value(forKey: "UUID") as? String {
        completion(message)
      }
    }
  }

  @objc static func observeUsers(completion: @escaping ([User]) -> Void) {
    //    ref.child("users").childByAutoId().setValue(["name": "Igor"])

    //TODO - need to fetch all users (not yourself)
    let ref = Database.database().reference()
    ref.child(Const.users).observe(.childAdded) { (snapshot) in
      guard let json = snapshot.value as? [String: Any],
        let message = Message(json: json)
        else { return }
      let measurements = message.messages.filter({ (message) -> Bool in
        message.userid != UserDefaults.standard.value(forKey: "UUID") as? String //(not yourself)
      })

      let users = measurements.compactMap({ (measurement) -> User? in
        let user = try? User.init(dictionary: measurement.toJson())
        return user
      })

      completion(users)
    }
  }

  @objc static func observeUserMeasurements(id: String, completion: @escaping (User?) -> Void) {
    //    ref.child("users").childByAutoId().setValue(["name": "Igor"])

    //TODO - need to fetch last measurements from user

    let ref = Database.database().reference()
    ref.child(Const.measurement).observe(.childAdded) { (snapshot) in
      guard let json = snapshot.value as? [String: Any],
        let message = Message(json: json)
        else { return }

      let measurement = message.messages.first(where: { (message) -> Bool in
         message.userid == id
      })

      if measurement != nil {
        let user = try? User.init(dictionary: measurement!.toJson())
        completion(user)
      }
    }
  }
  
  @objc static func addValue(database: String, json: [String: Any]?) {
    let ref = Database.database().reference()
    ref.child(database).childByAutoId().setValue(json)
  }
}

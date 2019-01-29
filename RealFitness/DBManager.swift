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
    static let dbName = "measurement"
  }
  
  //  static var ref: DatabaseReference!
  
  @objc static func initDB() {
    FirebaseApp.configure()
  }
  
  @objc static func observe(completion: @escaping (Message?) -> Void) {
    //    ref.child("users").childByAutoId().setValue(["name": "Igor"])
    let ref = Database.database().reference()
    ref.child(Const.dbName).observe(.childAdded) { (snapshot) in
      guard let json = snapshot.value as? [String: Any],
            let message = Message(json: json)
      else { return }
      if message.messages.first?.userid == UserDefaults.standard.value(forKey: "UUID") as? String {
        completion(message)
      }
    }
  }
  
  @objc static func addValue(json: [String: Any]?) {
    let ref = Database.database().reference()
    ref.child(Const.dbName).childByAutoId().setValue(json)
  }
  
}

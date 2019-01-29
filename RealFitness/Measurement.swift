//
//  Measurement.swift
//  RealFitness
//
//  Created by Игорь on 29/01/2019.
//  Copyright © 2019 Satori Worldwide, Inc. All rights reserved.
//

import Foundation

struct Measurement: JsonMappable {
  
  //  enum Type: JsonMappable {
  //    case jogging, longrunning, sprint
  //  }
  
  let calories: String
  let distance: String
  let duration: String
  let heartrange: String
  let heartrate: String
  let userid: String
  let username: String
  let workoutgoal: String
  
}

class Message: NSObject, JsonMappable {
  
  let messages: [Measurement]
  
}

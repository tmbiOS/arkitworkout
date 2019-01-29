//
//  Measurement.swift
//  RealFitness
//
//  Created by Игорь on 29/01/2019.
//  Copyright © 2019 Satori Worldwide, Inc. All rights reserved.
//

import Foundation

class Measurement: NSObject, JsonMappable {
  
  //  enum Type: JsonMappable {
  //    case jogging, longrunning, sprint
  //  }
  
  var calories: String
  var distance: String
  var duration: String
  var heartrange: String
  var heartrate: String
  var userid: String
  var username: String
  var workoutgoal: String
  
}

class Message: NSObject, JsonMappable {
  
  let messages: [Measurement]
  
}

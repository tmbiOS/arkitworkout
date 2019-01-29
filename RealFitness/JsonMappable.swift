//
//  JsonMappable.swift
//  Poc
//
//  Created by Andrey Rudenko on 13/10/2018.
//  Copyright © 2018 Vitim. All rights reserved.
//

import Foundation

protocol JsonMappable: Codable {
  init?(jsonData: Data)
  init?(jsonString: String?)
  init?(json: [String: Any]?)
  func toJsonString() -> String?
  func toJson() -> [String: Any]?
}

extension JsonMappable {
  
  init?(jsonData: Data) {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    guard let data = try? decoder.decode(Self.self, from: jsonData) else {
      return nil
    }
    self = data
  }
  
  init?(jsonString: String?) {
    guard let data = jsonString?.data(using: .utf8) else {
      return nil
    }
    self.init(jsonData: data)
  }
  
  init?(json: [String: Any]?) {
    guard let json = json,
      let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
        return nil
    }
    self.init(jsonData: data)
  }
  
  
  func toJsonString() -> String? {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    encoder.outputFormatting = .prettyPrinted
    guard let data = try? encoder.encode(self) else { return nil }
    return String(bytes: data, encoding: .utf8)
  }
  
  func toJson() -> [String: Any]? {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    encoder.outputFormatting = .prettyPrinted
    guard let data = try? encoder.encode(self),
      let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
      else { return nil }
    return json
  }
  
  
}

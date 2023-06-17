//
//  NetworkError.swift
//  Yelp
//
//  Created by JonathanTriC on 16/06/23.
//

import Foundation
import Alamofire

struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}

//
//  DataSource.swift
//  Core
//
//  Created by Dimas Oktanugraha on 28/09/25.
//

import Combine
 
public protocol DataSource {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> AnyPublisher<Response, Error>
}

//
//  LocaleDataSource.swift
//  Core
//
//  Created by Dimas Oktanugraha on 28/09/25.
//

import Combine
 
public protocol RemoteDataSource {
  associatedtype Request
  associatedtype Response
    
  func list(request: Request?) -> AnyPublisher<[Response], Error>
  func getById(id: Int) -> AnyPublisher<Response, Error>
}

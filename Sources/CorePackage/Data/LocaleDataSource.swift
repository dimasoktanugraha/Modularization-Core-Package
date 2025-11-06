//
//  LocaleDataSource.swift
//  Core
//
//  Created by Dimas Oktanugraha on 28/09/25.
//

import Combine
 
public protocol LocaleDataSource {
  associatedtype Request
  associatedtype Response
    
  func list() -> AnyPublisher<[Response], Error>
  func getById(id: Int) -> AnyPublisher<Response, Error>
  func isExists(id: Int) -> AnyPublisher<Bool, Error>
  func add(entity: Request) -> AnyPublisher<Bool, Error>
  func addAll(entities: [Request]) -> AnyPublisher<Bool, Error>
  func delete(id: Int) -> AnyPublisher<Bool, Error>
}

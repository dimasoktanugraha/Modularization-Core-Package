//
//  Mapper.swift
//  Core
//
//  Created by Dimas Oktanugraha on 29/09/25.
//

import Foundation
 
public protocol Mapper {
  associatedtype Response
  associatedtype Entity
  associatedtype Domain
  
  func transformResponseToDomain(response: Response) -> Domain
  func transformResponseToEntity(response: Response) -> Entity
  func transformEntityToDomain(entity: Entity) -> Domain
}

//
//  GetListPresenter.swift
//  Core
//
//  Created by Dimas Oktanugraha on 28/09/25.
//

import SwiftUI
import Combine
 
public class GetListPresenter<
  Request,
  Response,
  Interactor: UseCase
>: ObservableObject where Interactor.Request == Request, Interactor.Response == [Response] {
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let _useCase: Interactor
  
  @Published public var list: [Response] = []
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  
  public init(useCase: Interactor) {
      _useCase = useCase
  }
  
  public func getList(request: Request?) {
    print("🟢 GetListPresenter ")
      isLoading = true
      _useCase.execute(request: request)
          .receive(on: RunLoop.main)
          .sink(receiveCompletion: { [weak self] completion in
              switch completion {
              case .failure(let error):
                print("🟢 failure :", error.localizedDescription)
                self?.errorMessage = error.localizedDescription
                self?.isError = true
                self?.isLoading = false
              case .finished:
                self?.isLoading = false
              }
          }, receiveValue: { list in
            print("🟢 receiveValue :", list.count)
              self.list = list
          })
          .store(in: &cancellables)
  }
}

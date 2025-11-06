//
//  GetListPresenter.swift
//  Core
//
//  Created by Dimas Oktanugraha on 28/09/25.
//

import SwiftUI
import Combine
 
public class GetByIdPresenter<
  Request,
  Response,
  Interactor: UseCase
>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _useCase: Interactor
    
    @Published public var item: Response?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    @MainActor
    public init(useCase: Interactor) {
        _useCase = useCase
    }
    
    public func getById(request: Request?) {
      print("GetByIdPresenter.getById")
      isLoading = true
      isError = false
      errorMessage = ""
      
      _useCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
              guard let self else { return }
              switch completion {
              case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isError = true
                self.isLoading = false
              case .finished:
                self.isLoading = false
              }
            }, receiveValue: { [weak self] item in
              guard let self else { return }
              self.item = item
              self.isLoading = false
            })
            .store(in: &cancellables)
    }
}

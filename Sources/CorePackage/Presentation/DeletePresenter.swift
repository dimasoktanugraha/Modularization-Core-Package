//
//  GetListPresenter.swift
//  Core
//
//  Created by Dimas Oktanugraha on 28/09/25.
//

import SwiftUI
import Combine
 
public class AddPresenter<
    Request,
    Response,
    Interactor: UseCase
>: ObservableObject where Interactor.Request == Request, Interactor.Response == Bool {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _useCase: Interactor
    
    @Published public var isDeleted: Bool = false
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(useCase: Interactor) {
        _useCase = useCase
    }
    
    public func delete(request: Request?) {
        isLoading = true
        _useCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                  self?.errorMessage = error.localizedDescription
                  self?.isError = true
                  self?.isLoading = false
                case .finished:
                  self?.isLoading = false
                }
            }, receiveValue: { _ in
              self.isDeleted = true
            })
            .store(in: &cancellables)
    }
}

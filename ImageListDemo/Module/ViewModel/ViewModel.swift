//
//  ViewModel.swift
//  ImageListDemo
//
//  Created by Bishal Ram on 15/05/24.
//

import Foundation

protocol ViewModelProtocol {
    var onDataUpdate: ((Result<Bool, NetworkError>) -> Void)? { get set }
    var imageList: [ListData] { get }
    func fetchImages()
}

final class ViewModel: ViewModelProtocol {
    var onDataUpdate: ((Result<Bool, NetworkError>) -> Void)?
    var imageList = [ListData]()
    
    private let networkService: NetworkServiceProtocol
    
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    
    func fetchImages() {
        networkService.request(route: .endpoint, method: .get) { [weak self] response, error  in
            
            guard let self = self else { return }
            if let error = error {
                self.onDataUpdate?(.failure(error))
                return
            } else {
                if let response = response {
                    self.imageList.append(contentsOf: response)
                    self.onDataUpdate?(.success(true))
                }
            }
        }
    }
    
}

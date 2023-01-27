//
//  ViewModel.swift
//  Demo
//
//  Created by Pablo Martinez Piles on 27/01/2023.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    let githubUserService: GithubUsersService
    
    @Published var users: [GithubUser] = []
    @Published var errorMsg: String?
    
    private var bags: Set<AnyCancellable> = Set()
    
    init(githubUserService: GithubUsersService) {
        self.githubUserService = githubUserService
    }
    
    func getGitHubUsers() {
        githubUserService.getUsers()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                switch error {
                case let .failure(error):
                    self?.errorMsg = error.localizedDescription
                case .finished:
                    break
                }
        } receiveValue: { [weak self] users in
            self?.users = users
        }
        .store(in: &bags)
    }
}

//
//  GithubServiceMock.swift
//  DemoTests
//
//  Created by Pablo Martinez Piles on 27/01/2023.
//

import Foundation
@testable import Demo
import Combine

class GithubUserServiceMock: GithubUsersService {
    var users: [GithubUser] = []
    func getUsers() -> Future<[GithubUser], GitHubError> {
        return Future { promise in
            promise(.success(self.users))
        }
    }
}

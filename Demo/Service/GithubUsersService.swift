//
//  GithubUsersService.swift
//  Demo
//
//  Created by Pablo Martinez Piles on 27/01/2023.
//

import Foundation
import Combine


protocol GithubUsersService {
    func getUsers() -> Future<[GithubUser], GitHubError>
}


enum GitHubError: Error {
    case noData
    case parseError
    case error(Error)
}

class GithubUserServiceImpl: GithubUsersService {
    
    private let gitHubUsersEndpoint: String = "https://api.github.com/users"
    
    func getUsers() -> Future<[GithubUser], GitHubError> {
        Future { promise in
            let url = URL(string: self.gitHubUsersEndpoint)

            let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if let error = error {
                    promise(.failure(.error(error)))
                    return
                }
                guard let data = data else {
                    promise(.failure(.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let objectList = try decoder.decode([GithubUser].self, from: data)
                    promise(.success(objectList))
                }catch {
                    promise(.failure(.parseError))
                    return
                }
            })

            task.resume()
        }
    }
}

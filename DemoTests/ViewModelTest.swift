//
//  ViewModelTest.swift
//  DemoTests
//
//  Created by Pablo Martinez Piles on 27/01/2023.
//

import XCTest
@testable import Demo
import Combine

final class ViewModelTest: XCTestCase {
    
    var gitGubUserServiceMock: GithubUserServiceMock!
    
    var cancelables: Set<AnyCancellable> = Set()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        gitGubUserServiceMock = GithubUserServiceMock()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test() throws {
        gitGubUserServiceMock.users = [GithubUser(id: 1, type: "", login: "Pablo", avatarUrl: "")]
        let viewModel = setupViewModel(usersService: gitGubUserServiceMock)
        viewModel.getGitHubUsers()
        
        let expectation = XCTestExpectation(description: "Gets values")
        viewModel.$users
            .dropFirst()
            .sink { completion in
                switch completion {
                case .failure(_):
                    XCTFail("Error retreiving users")
                case .finished:
                    break
                }
                
            } receiveValue: { users in
                XCTAssert(users.count == 1)
                XCTAssert(users.first?.login == "Pablo")
                expectation.fulfill()
            }
            .store(in: &cancelables)

        wait(for: [expectation], timeout: 5.0)
    }
    
    private func setupViewModel(usersService: GithubUsersService) -> ViewModel {
        ViewModel(githubUserService: usersService)
    }

}

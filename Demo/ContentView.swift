//
//  ContentView.swift
//  Demo
//
//  Created by Pablo Martinez Piles on 27/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel: ViewModel = ViewModel(githubUserService: GithubUserServiceImpl())
    
    var body: some View {
        ListUsers(users: viewModel.users)
            .onAppear {
                viewModel.getGitHubUsers()
            }
    }
}

struct ListUsers: View {
    let users: [GithubUser]
    
    var body: some View {
        List(users) { user in
            UserItemView(user: user)
        }
    }
}


struct UserItemView: View {
    let user: GithubUser
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(.init(1), contentMode: .fill)
                    .clipShape(Circle())
            } placeholder: {
                
            }

            Text(user.login)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

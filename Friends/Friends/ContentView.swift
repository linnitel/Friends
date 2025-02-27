//
//  ContentView.swift
//  Friends
//
//  Created by Julia Martcenko on 27/02/2025.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var viewModel = UserViewModel()

    var body: some View {
		NavigationStack {
			List(viewModel.users) { user in
				NavigationLink(value: user) {
					UserCellView(user: user)
				}
			}
			.navigationTitle("FriendFace")
			.navigationDestination(for: User.self) { user in
				DetailView(user: user)
			}
			.onAppear {
				viewModel.fetchUsers()
			}
		}
    }
}

struct UserCellView: View {
	let user: User

	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(user.name).font(.headline)
				Text("Company: \(user.company)")
					.font(.subheadline)
					.foregroundStyle(.gray)
			}
			Spacer()
			Image(systemName: user.isActive ? "checkmark.circle.fill" : "xmark.circle.fill")
				.foregroundStyle( user.isActive ? .green : .gray)
		}
	}
}


#Preview {
    ContentView()
}

//
//  DetailView.swift
//  Friends
//
//  Created by Julia Martcenko on 27/02/2025.
//

import SwiftUI

struct DetailView: View {
	@Environment(\.dismiss) var dismiss
	let user: User

    var body: some View {
			Form {
				Section {
					HStack {
						Text("Is active:")
						Spacer()
						Image(systemName: user.isActive ? "checkmark.circle.fill" : "xmark.circle.fill")
							.foregroundStyle( user.isActive ? .green : .gray)
					}
					HStack {
						Text("Join date:")
						Spacer()
						Text(user.registered.formatted(date: .long, time: .shortened))
					}
					FieldView(title: "Age:", value: "\(user.age)")
				}
				Section {
					FieldView(title: "Company name:", value: "\(user.company)")
					FieldView(title: "email:", value: "\(user.email)")
					FieldView(title: "Address:", value: "\(user.address)")
				}
				Section("About") {
					Text(user.about)
				}
				Section("Tags:") {
					ForEach(user.tags, id: \.self) { tag in
						Text(tag)
					}
				}
				Section("Friends") {
					ForEach(user.friends, id: \.self) { friend in
						Text(friend.name)
					}
				}

			}
			.navigationTitle(user.name)
    }
}

struct FieldView: View {
	let title: String
	let value: String

	var body: some View {
		HStack {
			Text(title)
			Spacer()
			Text(value)
		}
	}
}

#Preview {
	DetailView(user: User(id: UUID(), isActive: true, name: "Name", age: 39, company: "some", email: "email@email.com", address: "some street", about: "some large text shoud be here", registered: .now, tags: ["consfd", "jlsdkfjl", "sdfljkjafpwipwir", "slakjf"], friends: [Friend(id: UUID(), name: "SOmflsjkfd"), Friend(id: UUID(), name: "KDlsjflj")]))
}

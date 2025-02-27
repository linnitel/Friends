//
//  Users.swift
//  Friends
//
//  Created by Julia Martcenko on 27/02/2025.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
	var id: UUID
	var isActive: Bool
	var name: String
	var age: Int
	var company: String
	var email: String
	var address: String
	var about: String
	var registered: Date
	var tags: [String]
	var friends: [Friend]
}

struct Friend: Codable, Identifiable, Hashable {
	var id: UUID
	var name: String
}

class UserViewModel: ObservableObject {
	@Published var users: [User] = []

	func fetchUsers() {
		guard users.isEmpty else { return }

		guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
			print("Invalid URL")
			return
		}

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601 // Ensure correct Date format

		URLSession.shared.dataTask(with: url) { data, response, error in
			if let data = data {
				do {
					let decodedUsers = try decoder.decode([User].self, from: data)
					DispatchQueue.main.async {
						self.users = decodedUsers
					}
				} catch {
					print("Decoding error: \(error)")
				}
			} else if let error = error {
				print("Error fetching data: \(error)")
			}
		}.resume()
	}
}

//
//  ValidateAddress.swift
//  SwiftSample (iOS)
//
//  Created by Adrianne Sun on 6/3/25.
//
import Foundation

struct ValidationResponse: Decodable {
    let valid: Bool
}

struct ValidateAddress {
    static func validate(address: String, city: String, zipcode: String, state: String) async throws -> Bool {
        guard let url = URL(string: "http://127.0.0.1:8000/validate-address") else {
            print("Invalid URL")
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload: [String: String] = [
            "address": address,
            "city": city,
            "zipcode": zipcode,
            "state": state
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: payload, options: [])
        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response")
            throw URLError(.badServerResponse)
        }

        let bodyString = String(data: data, encoding: .utf8) ?? ""

        if httpResponse.statusCode == 200 {
            print("Address validation success: \(bodyString)")

            let decoded = try JSONDecoder().decode(ValidationResponse.self, from: data)
            return decoded.valid
        } else {
            print("Address validation failed: \(httpResponse.statusCode) - \(bodyString)")
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: bodyString])
        }
    }
}

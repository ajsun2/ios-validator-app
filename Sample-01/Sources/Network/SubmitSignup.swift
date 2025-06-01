//
//  SubmitSignup.swift
//  SwiftSample (iOS)
//
//  Created by Adrianne Sun on 4/23/25.
//

import Foundation

struct SubmitSignup {
    static func submit(formData: [String: String]) async throws -> String {
        guard let url = URL(string: "http://127.0.0.1:8000/signup") else {
            print("Invalid URL")
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonData = try JSONSerialization.data(withJSONObject: formData, options: [])
        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response")
            throw URLError(.badServerResponse)
        }
        
        let body = String(data: data , encoding: .utf8) ?? ""
        
        if httpResponse.statusCode == 200 {
            print("Signup successful: \(body)")
            return String(data: data, encoding: .utf8) ?? "Success"
        } else {
            print("Signup failed: \(httpResponse.statusCode) - \(body)")
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
        }
    }
}


//struct SubmitSignup {
//    static func submit(formData: [String: String]) {
//        guard let url = URL(string: "http://127.0.0.1:8000/signup") else {
//            print("Invalid URL")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: formData, options: [])
//            request.httpBody = jsonData
//        } catch {
//            print("Error serializing JSON: \(error)")
//            return
//        }
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Request error: \(error)")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse else {
//                print("Invalid response")
//                return
//            }
//
//            let body = String(data: data ?? Data(), encoding: .utf8) ?? ""
//
//            if httpResponse.statusCode == 200 {
//                print("Signup successful: \(body)")
//            } else {
//                print("Signup failed: \(httpResponse.statusCode) - \(body)")
//            }
//        }.resume()
//    }
//}

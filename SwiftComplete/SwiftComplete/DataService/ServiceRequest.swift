//
//  ServiceRequest.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 13/11/24.
//

import UIKit
import Foundation
/*
 In this class I was trying to create a api request method for sample purpose
 */
 
class ServiceRequest {
    var userList: [User]?
    
    init() {
        Task{
            await ApiCalling()
        }
    }
    
    func getdata() async throws -> [User]?{
        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        // Create a URLSession instance
        do {
            let session = URLSession.shared
            let (data, _) = try await session.data(from: url)
            let users = try JSONDecoder().decode([User].self, from: data)
            return users
        } catch {
            // Catch network or decoding errors and propagate them
            if let urlError = error as? URLError {
                throw NetworkError.networkError(urlError)
            } else if let decodingError = error as? DecodingError {
                throw NetworkError.decodingError(decodingError)
            } else {
                // For any other unexpected errors
                throw NetworkError.networkError(error)
            }
        }
        
    }
    func ApiCalling() async{
        do{
            if let users = try await getdata(){
                self.userList = users
            }else{
                print("No user")
            }
            
        } catch NetworkError.invalidURL {
            print("The URL was invalid.")
            
        } catch NetworkError.networkError(let error) {
            print("Network error occurred: \(error.localizedDescription)")
            
        } catch NetworkError.decodingError(let error) {
            print("Decoding error occurred: \(error.localizedDescription)")
            
        } catch {
            // Handle any other unexpected errors
            print("An unknown error occurred: \(error.localizedDescription)")
        }
        
    }
}

struct User: Decodable {
    let name: String
    let email: String
    let body: String
}
enum NetworkError: Error {
    case invalidURL
    case decodingError(Error)
    case networkError(Error)
}




//
//  YourAPIService.swift
//  Pagination_MVVM
//
//  Created by PHN MAC 1 on 22/09/23.
//

import Foundation
enum Event{
    case startLoading
    case stopLoading
    case reloadData
    case error(NetworkError)
}

enum NetworkError: Error {
    case badURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}

final class YourAPIService {
    static let baseURL = "https://jsonplaceholder.typicode.com/" // Replace with your API endpoint

    static func fetchData(page: Int, pageSize: Int, completion: @escaping (Result<[PhotosModel], NetworkError>) -> Void) {
        // Create the URL for your API endpoint with pagination parameters
        guard var urlComponents = URLComponents(string: baseURL + "photos") else {
            completion(.failure(.badURL))
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "_page", value: "\(page)"),
            URLQueryItem(name: "_limit", value: "\(pageSize)")
        ]

        guard let url = urlComponents.url else {
            completion(.failure(.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode([PhotosModel].self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}

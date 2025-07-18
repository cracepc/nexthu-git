import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
}

protocol NetworkServiceProtocol {
    func get<T: Codable>(url: String, type: T.Type) async throws -> T
    func post<T: Codable>(url: String, body: Data, type: T.Type) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://api.example.com"
    
    func get<T: Codable>(url: String, type: T.Type) async throws -> T {
        guard let url = URL(string: baseURL + url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode != 200 {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            let decoded = try JSONDecoder().decode(type, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func post<T: Codable>(url: String, body: Data, type: T.Type) async throws -> T {
        guard let url = URL(string: baseURL + url) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode != 200 {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            let decoded = try JSONDecoder().decode(type, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError
        }
    }
}
import Foundation

struct APIService {
    
    private static var authToken: String? {
        return KeychainHelper.standard.readString(forKey: "accessToken")
    }
    
    static func postRequest<T: Codable>(url: URL, body: [String: Any], responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = authToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        logRequest(request: request, body: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            logResponse(data: data)

            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedResponse))
            } catch {
                if let apiError = try? JSONDecoder().decode(GeneralResponse.self, from: data) {
                    completion(.failure(APIError.custom(apiError.message)))
                } else {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    static func putRequest<T: Decodable>(url: URL, body: [String: Any], responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = authToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            completion(.failure(error))
            return
        }
        
        logRequest(request: request, body: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "No data", code: 0)))
                }
                return
            }
            
            logResponse(data: data)
            
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedResponse))
            } catch {
                if let apiError = try? JSONDecoder().decode(GeneralResponse.self, from: data) {
                    completion(.failure(APIError.custom(apiError.message)))
                } else {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    // MARK: - Debug log helpers
    
    private static func logRequest(request: URLRequest, body: [String: Any]) {
        print("🔹 API Request:")
        print("➡️ URL: \(request.url?.absoluteString ?? "nil")")
        print("➡️ Method: \(request.httpMethod ?? "nil")")
        print("➡️ Headers: \(request.allHTTPHeaderFields ?? [:])")
        if let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("➡️ Body: \(jsonString)")
        }
    }
    
    private static func logResponse(data: Data) {
        if let jsonString = String(data: data, encoding: .utf8) {
            print("🔸 API Response: \(jsonString)")
        } else {
            print("🔸 API Response: [Unable to decode response data]")
        }
    }
}

//
//  NetWorkService.swift
//  WeatherApp
//
//  Created by durodola on 29/06/2024.
//

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    func getWeatherDetails(CityName: String, units: String, appID: String, completion: @escaping(Result<WeatherResponse, Error>)-> Void) {
        request(route: .fetchWeatherDetails(CityName: CityName, units: units, appID: appID), method: .get, completion: completion)
    }
    
    private func request<T: Decodable>(route: Route,
                                       method: Method,
                                       parameters: [String: Any]? = nil,
                                       completion: @escaping(Result<T, Error>) -> Void) {
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(NetworkingError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify data"
                print("This is \(responseString)")
                
            } else if let error = error {
                result = .failure(error)
                print("Error is \(error.localizedDescription )")
            }
            
            guard let status = response as? HTTPURLResponse else {
                return
            }
            print(status.statusCode)
            
            if status.statusCode == 401 {
                  DispatchQueue.main.async {
//                Util.redirectToReturningVC()
                      print("401 Error")
                    return
                }
            }
            
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?, completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(NetworkingError.unknownError))
            
            return
        }
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(T.self, from: data)
            else {
                completion(.failure(NetworkingError.errorDecoding))
                return
            }
            completion(.success(response))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest?
    {
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        print(url, "urrrrllrlllr")
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderConstant.contentType)
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderConstant.accept)
//        urlRequest.setValue("\(UserDefault.getAuthToken() ?? "")", forHTTPHeaderField: HeaderConstant.tokenHeader)
        
        
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map{(URLQueryItem(name: $0, value: "\($1)"))}
                urlRequest.url = urlComponent?.url
            case .post:
                do {
                   let bodyData = try JSONSerialization.data(withJSONObject: params, options: [])
                    urlRequest.httpBody = bodyData
                    urlRequest.timeoutInterval = 60
                } catch {
                    print(error, error.localizedDescription, "EErrr :" )
                }
            }
        }
        return urlRequest
    }

}


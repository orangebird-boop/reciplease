import Foundation

enum ServiceError: Error {
    case unknown
    case invalidURL
    case emptyData
    case failedToDeserialize
    case redirection
    case httpClientError
    case serverError

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown"
        case .invalidURL:
            return "Invalid URL"
        case .emptyData:
            return "Empty Data"
        case .failedToDeserialize:
            return "Failed to deserialize"
        case .redirection:
            return "Redirection"
        case .httpClientError:
            return "http client error"
        case .serverError:
            return "server error"
        }
    }
}

protocol NetworkServiceProtocol {
    func get<T>(request: URLRequest, completionHandler: @escaping (Result<T, ServiceError>) -> Void) where T: Decodable
}

struct NetworkService: NetworkServiceProtocol {

    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func get<T>(request: URLRequest, completionHandler: @escaping (Result<T, ServiceError>) -> Void) where T: Decodable {
        urlSession
            .dataTask(with: request) { data, response, error in
                if error != nil {
                    dump(error)
                    completionHandler(.failure(.unknown))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    completionHandler(.failure(.unknown))
                    return
                }

                switch httpResponse.statusCode {
                case 200..<300:
                    guard let data = data else {
                        completionHandler(.failure(.emptyData))
                        return
                    }

                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        completionHandler(.success(model))
                    } catch {
                        dump(error)
                        completionHandler(.failure(.failedToDeserialize))
                    }

                case 300..<400:
                    completionHandler(.failure(.redirection))
                case 400..<500:
                    completionHandler(.failure(.httpClientError))
                case 500..<600:
                    completionHandler(.failure(.serverError))
                default:
                    completionHandler(.failure(.unknown))
                }
            }
            .resume()
    }
}

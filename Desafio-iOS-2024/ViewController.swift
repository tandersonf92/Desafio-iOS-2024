//
//  ViewController.swift
//  Desafio-iOS-2024
//
//  Created by Anderson Oliveira on 07/12/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        print("viewDIdLoad")
        call()
    }

    private let baseURL = "https://xd5zl5kk2yltomvw5fb37y3bm40vsyrx.lambda-url.sa-east-1.on.aws"
    let estimateURL = "/ride/estimate"

    func createPostRequest() -> URLRequest? {
        
        let origin = "Av. Pres. Kenedy, 2385 - Remédios, Osasco - SP, 02675-031"
        let destination = "Av. Paulista, 1538 - Bela Vista, São Paulo - SP, 01310-200"
        
        let emptyValue: String? = nil
        let Emptydestination = ""
        let emptyId = ""
        
        let emptyParams: [String: Any] = [
            "origin": emptyValue,
            "destination": emptyValue,
            "customer_id": "123"
            ]
        
        let params: [String: Any] = [
            "origin": origin,
            "destination": destination,
            "customer_id": "123456789"
            ]

        guard let url = URL(string: "\(baseURL)\(estimateURL)") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: emptyParams)
        } catch {
            print("ERROR")
        }

        return request
    }

    func call() {
        let request = createPostRequest()
        let task = URLSession.shared.dataTask(with: request!) { data, response, error in
            if let error {
                print("ERROR: \(error)")
                print("error.localizedDescription: \(error.localizedDescription)")
            }
            guard let data else { return }
            print("DATA: \(data)")
            
            
            do {
                guard let response222 = response as? HTTPURLResponse else { return }
                switch response222.statusCode {
                case 400...499:
                    let response = try JSONDecoder().decode(RequestErrorResponse.self, from: data)
                    print("RESPONSUUUU: \(response.error_description)")
                    break
                    
                default:
                    print("CAI FORA DO ERROR 400")
                }
                
                let response = try JSONDecoder().decode(TripResultsListModel.self, from: data)
                print(response)
                
                
            } catch {
                print("ERROR")
            }
        }
        task.resume()

    }
}

public struct TripResultsListModel: Model {
    public let origin: Position
    public let destination: Position
    public let distance: Int
    public let duration: Int
    public let options: [Option]
    
    public init(origin: Position, destination: Position, distance: Int, duration: Int, options: [Option]) {
        self.origin = origin
        self.destination = destination
        self.distance = distance
        self.duration = duration
        self.options = options
    }
    
    public struct Position: Model {
        public let latitude: Double
        public let longitude: Double
        
        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
    
    public struct Option: Model {
        public let id: Int
        public let name: String
        public let description: String
        public let vehicle: String
        public let review: Review
        public let value: Double
        
        public init(id: Int, name: String, description: String, vehicle: String, review: Review, value: Double) {
            self.id = id
            self.name = name
            self.description = description
            self.vehicle = vehicle
            self.review = review
            self.value = value
        }
    }
    
    public struct Review: Model {
        public let rating: Int
        public let comment: String
        
        public init(rating: Int, comment: String) {
            self.rating = rating
            self.comment = comment
        }
    }
}

public protocol Model: Codable, Equatable {}

public extension Model {
    func toData() -> Data? {
        try? JSONEncoder().encode(self)
    }

    func toJson() -> [String: Any]? {
        guard let data = self.toData() else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
    }
}

struct RequestErrorResponse: Model {
    let errorCode: String // 400 -> "INVALID_DATA", + INVALID_DRIVER" 404: -> "DRIVER_NOT_FOUND", 406 -> "INVALID_DISTANCE"
    let error_description: String
}

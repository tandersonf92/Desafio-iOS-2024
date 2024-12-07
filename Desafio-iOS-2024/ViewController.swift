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
            request.httpBody = try JSONSerialization.data(withJSONObject: params)
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
            }
            guard let data else { return }
            print("DATA: \(data)")
//            do {
//                let response = try JSONDecoder().decode(Response.self, from: data)
//                print(response)
//            } catch {
//                print("ERROR")
//            }
        }
        task.resume()

    }
}

import Testing
@testable import Domain
import Foundation

final class TripResultsListUseCaseSpec {
    
    enum RequestScenario: CaseIterable {
        case success,
             error
    }
    
    enum TestScenario: CaseIterable {
        case allFieldsFilled,
             allFieldsEmpty, // ID error
             missingOrigin, // Origin Error
             missingDestination, // Destination Error
             missingId, // ID error,
             onlyIdFilled, // Destination Error
             onlyDestinationFilled, // ID error,
             onlyOriginFilled // ID error,
        
        var expectedModel: TravelFormModel {
            switch self {
            case .allFieldsFilled:
                makeExpectedModel()
            case .allFieldsEmpty:
                makeExpectedModel(origin: nil, destination: nil, customerId: nil)
            case .missingOrigin:
                makeExpectedModel(origin: nil)
            case .missingDestination:
                makeExpectedModel(destination: nil)
            case .missingId:
                makeExpectedModel(customerId: nil)
            case .onlyIdFilled:
                makeExpectedModel(origin: nil, destination: nil)
            case .onlyDestinationFilled:
                makeExpectedModel(origin: nil, customerId: nil)
            case .onlyOriginFilled:
                makeExpectedModel(destination: nil, customerId: nil)
            }
        }
        
        var domainError: DomainError? {
            switch self {
            case .allFieldsFilled:
                return nil
            case .missingOrigin:
                return .missingOrigin
            case .missingDestination, .onlyIdFilled:
                return .missingDestination
            case .allFieldsEmpty,
                    .missingId,
                    .onlyDestinationFilled,
                    .onlyOriginFilled:
                return .missingId
            }
        }
        
        private func makeExpectedModel(origin: String? = "any_origin",
                                       destination: String? = "any_destination",
                                       customerId: String? = "any_Id") -> TravelFormModel {
            TravelFormModel(origin: origin,
                            destination: destination,
                            customer_id: customerId)
        }
    }
    
    
    @Test("", arguments: TestScenario.allCases)
    func receivedModel(scenario: TestScenario) async throws {
        let spy = Spy()
        let sut = TripResultsListUseCase(repository: spy)
        
        sut.execute(using: scenario.expectedModel) { _ in }
        
        #expect(spy.reveivedModels == [scenario.expectedModel])
    }
    
    @Test("", arguments: TestScenario.allCases)
    func requestSnecarios(scenario: TestScenario) {
        let spy = Spy(expectedError: scenario.domainError)
        let sut = TripResultsListUseCase(repository: spy)
        
        sut.execute(using: TestScenario.allFieldsFilled.expectedModel) { result in
            switch result {
            case .success(let model):
                #expect(model == TripResultsListModelFactory.build())
            case .failure(let error):
                switch scenario {
                case .missingOrigin:
                    #expect(error == .missingOrigin)
                case .missingDestination, .onlyIdFilled:
                    #expect(error == .missingDestination)
                case .missingId, .allFieldsEmpty, .onlyDestinationFilled, .onlyOriginFilled:
                    #expect(error == .missingId)
                case .allFieldsFilled:
                    break
                }
            }
        }
        
    }
    
    //    final class TripResultsListUseCase {
    //
    //
    //        func getTripListResult(using model: TravelFormModel) {
    //
    //        }
    //    }
    //
    //    // MARK: Helpers
    //    private func makeRequest(expectedParams: [String: Any]) -> URLRequest? {
    //        let string = "https://xd5zl5kk2yltomvw5fb37y3bm40vsyrx.lambda-url.sa-east-1.on.aws/ride/estimate"
    //        guard let url = URL(string: string) else { return nil }
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //        request.httpBody = try? JSONSerialization.data(withJSONObject: expectedParams)
    //
    //        return request
    //    }
}

enum TripResultsListModelFactory {
    static func build() -> TripResultsListModel {
        TripResultsListModel(origin: .init(latitude: 1.23,
                                           longitude: 3.45),
                             destination: .init(latitude: 4.56,
                                                longitude: -2.1),
                             distance: 20018,
                             duration: 1920,
                             options: [.init(id: 1,
                                             name: "Any name",
                                             description: "Any description",
                                             vehicle: "Any vehicle",
                                             review: .init(rating: 4,
                                                           comment: "Any comment"),
                                             value: 100.09)])
    }
}

private final class Spy: TripResultsListRepositoryProtocol {
    
    var reveivedModels: [TravelFormModel] = []
    
    var expectedError: DomainError?
    
    init(expectedError: DomainError? = nil) {
        self.expectedError = expectedError
    }
    
    func getTripResults(using model: Domain.TravelFormModel, completion: @escaping (Result<Domain.TripResultsListModel, Domain.DomainError>) -> Void) {
        reveivedModels.append(model)
        guard let expectedError else {
            return completion(.success(TripResultsListModelFactory.build())) }
        completion(.failure(expectedError))
    }
}

import Testing
import Domain
import Foundation


struct TripResultsListUseCaseSpec {
//    
//    enum TestScenario: CaseIterable {
//        case allFieldsFilled,
//             allFieldsEmpty, // ID error
//             missingOrigin, // Origin Error
//             missingDestination, // Destination Error
//             missingId, // ID error,
//             onlyIdFilled, // Destination Error
//             onlyDestinationFilled, // ID error,
//             onlyOriginFilled // ID error,
//        var expectedModel: TravelFormModel {
//            switch self {
//            case .allFieldsFilled:
//                makeExpectedModel()
//            case .allFieldsEmpty:
//                makeExpectedModel(origin: nil, destination: nil, customerId: nil)
//            case .missingOrigin:
//                makeExpectedModel(origin: nil)
//            case .missingDestination:
//                makeExpectedModel(destination: nil)
//            case .missingId:
//                makeExpectedModel(customerId: nil)
//            case .onlyIdFilled:
//                makeExpectedModel(origin: nil, destination: nil)
//            case .onlyDestinationFilled:
//                makeExpectedModel(origin: nil, customerId: nil)
//            case .onlyOriginFilled:
//                makeExpectedModel(destination: nil, customerId: nil)
//            }
//        }
//        
//        private func makeExpectedModel(origin: String? = "any_origin",
//                                       destination: String? = "any_destination",
//                                       customerId: String? = "any_Id") -> TravelFormModel {
//            TravelFormModel(origin: origin,
//                            destination: destination,
//                            customer_id: customerId)
//        }
//    }
//    
//    
//    @Test("", arguments: TestScenario.allCases)
//    func test_(scenario: TestScenario) {
//        let sut = TripResultsListUseCase()
//        
//        sut.getTripListResult(using: scenario.expectedModel)
//        
//        #expect(spy.receivedRequests == [])
//        
//        
//        
//    }
//    
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

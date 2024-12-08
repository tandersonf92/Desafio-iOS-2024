import Foundation

protocol TripResultsListRepositoryProtocol {
    func getTripResults(using model: TravelFormModel, completion: @escaping (TripResultsListUseCaseProtocol.Result) -> Void)
}

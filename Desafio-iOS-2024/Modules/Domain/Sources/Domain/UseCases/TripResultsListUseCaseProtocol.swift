import Foundation

public protocol TripResultsListUseCaseProtocol {
    typealias Result = Swift.Result<TripResultsListModel, DomainError>
    func execute(using model: TravelFormModel, completion: @escaping (Result) -> Void)
}


final class TripResultsListUseCase: TripResultsListUseCaseProtocol {
   
    private let repository: TripResultsListRepositoryProtocol
    
    init(repository: TripResultsListRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(using model: TravelFormModel, completion: @escaping (TripResultsListUseCaseProtocol.Result) -> Void) {
        repository.getTripResults(using: model, completion: completion)
    }
}

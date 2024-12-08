public struct TripResultsListModel: Model {
    let origin: Position
    let destination: Position
    let distance: Int
    let duration: Int
    let options: [Option]
    
    public struct Position: Model {
        let latitude: Double
        let longitude: Double
    }
    
    public struct Option: Model {
        let id: Int
        let name: String
        let description: String
        let vehicle: String
        let review: Review
        let value: Int
    }
    
    public struct Review: Model {
        let rating: Int
        let comment: String
    }
}

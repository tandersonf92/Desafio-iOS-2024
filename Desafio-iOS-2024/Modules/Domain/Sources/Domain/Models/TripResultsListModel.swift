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

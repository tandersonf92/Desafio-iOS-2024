public struct TravelFormModel {
    public let origin: String?
    public let destination: String?
    public let customer_id: String?
    
    public init(origin: String?, destination: String?, customer_id: String?) {
        self.origin = origin
        self.destination = destination
        self.customer_id = customer_id
    }
}

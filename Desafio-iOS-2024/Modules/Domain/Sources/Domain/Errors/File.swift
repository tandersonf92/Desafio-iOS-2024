public enum DomainError: Error {
    case unexpected,
         missingId,
         missingDestination,
         missingOrigin
}
//
//public struct APIError: Codable, Error {
//    let statusCode: Int
//    let message: String
//    
//    
//    enum APIErrorMessage: String {
//        case missingId = "sem id de cliente"
//        case missingDestination = "Sem endereço de destino"
//        case missingOrigin = "Sem endereço de origem"
//    }
//}


enum APIErrorMessageBuilder {
    
    static func build(using message: String) -> DomainError {
        guard let errorMessage = ErrorMessage(rawValue: message.lowercased()) else {
            return .unexpected
        }
        
        switch errorMessage {
        case .missingId:
                return .missingId
        case .missingDestination:
            return .missingDestination
        case .missingOrigin:
            return .missingOrigin
        }
    }
    
    enum ErrorMessage: String {
        case missingId = "sem id de cliente"
        case missingDestination = "sem endereço de destino"
        case missingOrigin = "sem endereço de origem"
    }
}

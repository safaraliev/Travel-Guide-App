import Foundation
import MapKit

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let coordinate: CLLocationCoordinate2D
    let type: PlaceType
    let image: String
    
    enum PlaceType {
        case nature
        case culture
        case historical
        case entertainment
        
        var annotation: PlaceAnnotation {
            PlaceAnnotation(type: self)
        }
    }
} 
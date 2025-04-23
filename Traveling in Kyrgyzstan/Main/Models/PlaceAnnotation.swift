import MapKit

class PlaceAnnotation: MKPointAnnotation {
    let type: Place.PlaceType
    
    init(type: Place.PlaceType) {
        self.type = type
        super.init()
    }
} 
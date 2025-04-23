import UIKit
import SnapKit
import MapKit

class ExploreViewController: UIViewController {
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search places..."
        return search
    }()
    
    private let places: [Place] = [
        Place(name: "Issyk-Kul Lake",
              description: "The second largest saline lake in the world after the Caspian Sea. Crystal clear water surrounded by snow-capped mountains.",
              coordinate: CLLocationCoordinate2D(latitude: 42.4405, longitude: 77.2769),
              type: .nature,
              image: "issyk-kul"),
        
        Place(name: "Ala Archa National Park",
              description: "A natural park with scenic mountain landscapes, perfect for hiking and climbing. Located just 40 minutes from Bishkek.",
              coordinate: CLLocationCoordinate2D(latitude: 42.6333, longitude: 74.4833),
              type: .nature,
              image: "ala-archa"),
        
        Place(name: "Burana Tower",
              description: "An ancient minaret from the 11th century, important historical monument of architecture. Former part of ancient city Balasagun.",
              coordinate: CLLocationCoordinate2D(latitude: 42.7446, longitude: 75.2500),
              type: .culture,
              image: "burana"),
        
        Place(name: "Sulaiman-Too Sacred Mountain",
              description: "UNESCO World Heritage site in the center of Osh city. Features ancient petroglyphs, mosques and stunning panoramic views.",
              coordinate: CLLocationCoordinate2D(latitude: 40.5324, longitude: 72.7883),
              type: .culture,
              image: "sulaiman-too"),
        
        Place(name: "Song Kol Lake",
              description: "High-altitude alpine lake with traditional yurt camps. Experience authentic nomadic lifestyle and breathtaking mountain scenery.",
              coordinate: CLLocationCoordinate2D(latitude: 41.8391, longitude: 75.1216),
              type: .nature,
              image: "son-kul"),
        
        // New places
        Place(name: "Tash Rabat Caravanserai",
              description: "15th-century stone fortress and ancient inn along the Silk Road. Well-preserved historical monument in a spectacular mountain setting.",
              coordinate: CLLocationCoordinate2D(latitude: 41.2044, longitude: 75.1216),
              type: .culture,
              image: "tash-rabat"),
        
        Place(name: "Jeti-Oguz",
              description: "Famous red sandstone cliffs known as 'Seven Bulls'. Beautiful hiking area with hot springs and stunning mountain views.",
              coordinate: CLLocationCoordinate2D(latitude: 42.3284, longitude: 78.2907),
              type: .nature,
              image: "jeti-oguz"),
        
        Place(name: "Arslanbob",
              description: "World's largest natural walnut forest. Beautiful waterfalls and excellent hiking opportunities in a traditional Uzbek village setting.",
              coordinate: CLLocationCoordinate2D(latitude: 41.3438, longitude: 72.9282),
              type: .nature,
              image: "arslanbob"),
        
        Place(name: "Lenin Peak Base Camp",
              description: "Popular destination for mountaineers and hikers. Stunning views of Lenin Peak (7,134m) and the Pamir Mountains.",
              coordinate: CLLocationCoordinate2D(latitude: 39.3453, longitude: 72.8789),
              type: .nature,
              image: "lenin-peak"),
        
        Place(name: "Osh Bazaar",
              description: "One of the largest and oldest markets in Central Asia. Experience local culture, traditional foods and crafts.",
              coordinate: CLLocationCoordinate2D(latitude: 42.8746, longitude: 74.5698),
              type: .culture,
              image: "osh-bazaar"),
        
        Place(name: "Altyn Arashan",
              description: "Hot springs resort in a beautiful alpine valley. Perfect for hiking and enjoying natural thermal baths.",
              coordinate: CLLocationCoordinate2D(latitude: 42.3500, longitude: 78.5167),
              type: .nature,
              image: "altyn-arashan"),
        
        Place(name: "National History Museum",
              description: "Learn about Kyrgyz history and culture through extensive exhibits and artifacts in Bishkek.",
              coordinate: CLLocationCoordinate2D(latitude: 42.8746, longitude: 74.6122),
              type: .culture,
              image: "history-museum")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMap()
        addAnnotations()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Explore"
        
        view.addSubview(searchBar)
        view.addSubview(mapView)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        mapView.delegate = self
    }
    
    private func setupMap() {
        // Set map type and options
        mapView.mapType = .standard
        
        // Center the map on Kyrgyzstan
        let kyrgyzstanCenter = CLLocationCoordinate2D(latitude: 41.2044, longitude: 74.7661)
        let span = MKCoordinateSpan(latitudeDelta: 7.0, longitudeDelta: 7.0)
        let region = MKCoordinateRegion(center: kyrgyzstanCenter, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func addAnnotations() {
        places.forEach { place in
            let annotation = place.type.annotation
            annotation.title = place.name
            annotation.subtitle = place.description
            annotation.coordinate = place.coordinate
            mapView.addAnnotation(annotation)
        }
    }
}

extension ExploreViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? PlaceAnnotation else { return nil }
        
        let identifier = "PlaceMarker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        // Configure marker appearance based on place type
        switch annotation.type {
        case .nature:
            view.markerTintColor = .systemGreen
            view.glyphImage = UIImage(systemName: "leaf.fill")
        case .culture:
            view.markerTintColor = .systemOrange
            view.glyphImage = UIImage(systemName: "building.columns.fill")
        case .historical:
            view.markerTintColor = .systemBrown
            view.glyphImage = UIImage(systemName: "clock.fill")
        case .entertainment:
            view.markerTintColor = .systemPurple
            view.glyphImage = UIImage(systemName: "star.fill")
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? PlaceAnnotation,
              let title = annotation.title,
              let place = places.first(where: { $0.name == title }) else { return }
        
        let detailVC = PlaceDetailViewController(place: place)
        navigationController?.pushViewController(detailVC, animated: true)
    }
} 

import Foundation
import MapKit

class PlacesManager {
    static let shared = PlacesManager()
    
    let places: [Place] = [
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
    
    private init() {}
} 
import Foundation

struct Wine: Codable {
    let grapes: [String]
    let name: String
    let producer: String
    let country: String
    let region: String
    let imageURL: String
    let notes: String
    let year: Int?
    let wine_type: String?
    let restaurant: Int?

    // Generated values
//    let buyingPrice: Double
//    let sellingPrice: Double
//    var margin: Double {
//        return sellingPrice - buyingPrice
//    }
//
//    // Custom initializer for generated values
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        grapes = try container.decode([String].self, forKey: .grapes)
//        name = try container.decode(String.self, forKey: .name)
//        producer = try container.decode(String.self, forKey: .producer)
//        country = try container.decode(String.self, forKey: .country)
//        region = try container.decode(String.self, forKey: .region)
//        imageURL = try container.decode(String.self, forKey: .imageURL)
//        notes = try container.decode(String.self, forKey: .notes)
//        year = try container.decodeIfPresent(Int.self, forKey: .year)
//        wine_type = try container.decodeIfPresent(String.self, forKey: .wine_type)
//        restaurant = try container.decodeIfPresent(Int.self, forKey: .restaurant)
//
//        // Generate buying/selling price (random example)
//        self.buyingPrice = Double.random(in: 10.0 ... 1000.0)
//        self.sellingPrice = Double.random(in: 30.0 ... 1000.0)
//    }

    // Coding keys to match your JSON keys exactly
    enum CodingKeys: String, CodingKey {
        case grapes, name, producer, country, region, imageURL, notes, year, wine_type, restaurant
    }
}

import Foundation

struct WineResponse: Codable {
    let wines: [Wine]
}

struct Wine: Codable {
    let wine_id: String
    let country: String
    let region_1: String?
    let variety: String
    let title: String
    let description: String
    let winery: String
    let points: String
    let price: String

    // Generated values
    let buyingPrice: Double
    let sellingPrice: Double
    var margin: Double {
        return sellingPrice - buyingPrice
    }

    enum CodingKeys: String, CodingKey {
        case wine_id, country, region_1, variety, title, description, winery, points, price
    }

    // Custom initializer to add generated fields
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        wine_id = try container.decode(String.self, forKey: .wine_id)
        country = try container.decode(String.self, forKey: .country)
        region_1 = try container.decodeIfPresent(String.self, forKey: .region_1) ?? "Unknown"
        variety = try container.decode(String.self, forKey: .variety)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        winery = try container.decode(String.self, forKey: .winery)
        points = try container.decode(String.self, forKey: .points)
        price = try container.decode(String.self, forKey: .price)

        // Generate buying/selling price
        let base = Double(price) ?? 10.0
        self.buyingPrice = Double.random(in: base * 0.5 ... base * 0.8)
        self.sellingPrice = Double.random(in: base * 1.0 ... base * 1.4)
    }
}

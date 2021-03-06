import Foundation

// Link: https://www.leandrofournier.com/working-with-json-part-2/
// JSON CUSTOM KEYS

// MARK: - JSON Parsing Function
func parseJSON(data: Data) {
	let decoder = JSONDecoder()
	
	if let output = try? decoder.decode(Product.self, from: data) {
		print(output)
	}
}

// MARK: - EXAMPLE 1: Custom Keys
let jsonString1 = """
{
    "product_id": 1423,
    "name": "Hockey Mask",
    "color-name": "white",
    "price-key-to-piss-the-developer-off": 39.90
}
"""

let jsonData1 = Data(jsonString1.utf8)

// Create JSON model
struct Product: Codable {
	let productId: Int
	let name: String
	let colorName: String?
	let price: Float
	
	enum CodingKeys: String, CodingKey {
		case productId = "product_id"
		case name
		case colorName = "color-name"
		case price = "price-key-to-piss-the-developer-off"
	}
}

parseJSON(data: jsonData1)

import Foundation

// Link: https://www.leandrofournier.com/working-with-json-part-2/
// JSON CUSTOM OBJECTS

// MARK: - JSON Parsing Function
func parseJSON(data: Data) {
	let decoder = JSONDecoder()
	
	if let output = try? decoder.decode(Product.self, from: data) {
		print(output)
	}
}

// MARK: - EXAMPLE 2: Custom Objects
let jsonString2 = """
{
    "productId": 1423,
    "name": "Hockey Mask",
    "color": "white",
    "price": {
        "price": 39.90,
        "currency": "USD",
        "formatted": "39.90 USD"
    }
}
"""

let jsonData2 = Data(jsonString2.utf8)

// Define JSON Model
struct Product: Codable {
	let productId: Int
	let name: String
	let color: String?
	let price: Price?
}

struct Price: Codable {
	let price: Float
	let currency: String
	let formatted: String
}

parseJSON(data: jsonData2)

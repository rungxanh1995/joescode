import Foundation

// Link: https://www.leandrofournier.com/working-with-json-part-1/
// JSON BASICS

// MARK: SAMPLE DATA
let jsonString = """
{
	"productId": 1423,
	"name": "Hockey Mask",
	"color": "white",
	"price": 39.90
}
"""

let jsonData = Data(jsonString.utf8)

// MARK: CREATE JSON MODEL
struct Product: Codable {
	let productId: Int
	let name: String
	let color: String?
	let price: Float
}

// MARK: JSON PARSING
let decoder = JSONDecoder()
if let product = try? decoder.decode(Product.self, from: jsonData) {
	print(product)
}

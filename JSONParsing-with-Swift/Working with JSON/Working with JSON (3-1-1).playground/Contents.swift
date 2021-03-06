import Foundation

// Link: https://www.leandrofournier.com/working-with-json-part-3/
// JSON ARRAYS

// MARK: - JSON Parsing Function
func parseJSON(data: Data) {
	let decoder = JSONDecoder()
	
	if let output = try? decoder.decode(Product.self, from: data) {
		print(output)
	}
}

// MARK: - EXAMPLE 1: Simple Array
let jsonString1 = """
{
   "productId":1423,
   "name":"Hockey Mask",
   "availableColors":[
      "white",
      "brown",
      "black"
   ],
   "price":39.90
}
"""

let jsonData1 = Data(jsonString1.utf8)

// JSON Model
struct Product: Codable {
	let productId: Int
	let name: String
	let availableColors: [String]
	let price: Float
}


parseJSON(data: jsonData1)

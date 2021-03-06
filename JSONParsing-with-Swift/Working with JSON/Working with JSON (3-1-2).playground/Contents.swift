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

// MARK: - EXAPLE 2: Complex Array
let jsonString2 = """
{
   "productId":1423,
   "name":"Hockey Mask",
   "availableColors":[
      "white",
      "brown",
      "black"
   ],
   "price":39.90,
   "stores":[
      {
         "name":"Gerry Cosby & Co., Inc.",
         "address":"11 Pennsylvania Plaza, New York, NY 10001, United States",
         "phone":"+1 877-563-6464"
      },
      {
         "name":"National Hockey League",
         "address":"1185 6th Ave, New York, NY 10036, United States",
         "phone":"+1 212-789-2000"
      },
      {
         "name":"Modell's Sporting Goods",
         "address":"234 W 42nd St, New York, NY 10036, United States",
         "phone":"+1 212-764-7030"
      }
   ]
}
"""

let jsonData2 = Data(jsonString2.utf8)

// JSON Model
struct Product: Codable {
	let productId: Int
	let name: String
	let availableColors: [String]
	let price: Float
	let stores: [Store]
}

struct Store: Codable {
	let name: String
	let address: String
	let phone: String?
}

parseJSON(data: jsonData2)

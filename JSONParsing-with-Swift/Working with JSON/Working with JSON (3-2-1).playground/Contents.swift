import Foundation

// Link: https://www.leandrofournier.com/working-with-json-part-3/
// JSON TOP LEVEL ENTITIES

// MARK: - JSON Parsing Function
func parseJSON(data: Data) {
	let decoder = JSONDecoder()
	
	if let output = try? decoder.decode(StoresList.self, from: data) {
		print(output)
	}
}

// MARK: - EXAPLE: JSON with top level entities
////APIs tend to use a wrapper key so that the top level entity of the JSON is an object.
let jsonString = """
{
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
let jsonData = Data(jsonString.utf8)

// JSON Model
struct StoresList: Codable {
	let stores: [Store]
}

struct Store: Codable {
	let name: String
	let address: String
	let phone: String?
}

parseJSON(data: jsonData)

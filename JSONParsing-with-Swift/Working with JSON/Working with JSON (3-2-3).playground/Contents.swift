import Foundation

// Link: https://www.leandrofournier.com/working-with-json-part-3/
// JSON TOP LEVEL ENTITIES

// MARK: - EXAPLE: JSON with NO top level entities, but MULTIPLE child entities
// APIs tend to use a wrapper key so that the top level entity of the JSON is an object.
// BUT what if there's no wrapper keys, but multiple child entities?
let jsonString = """
[
   {
      "Gerry Cosby & Co., Inc.":{
         "address":"11 Pennsylvania Plaza, New York, NY 10001, United States",
         "phone":"+1 877-563-6464"
      },
      "National Hockey League":{
         "address":"1185 6th Ave, New York, NY 10036, United States",
         "phone":"+1 212-789-2000"
      },
      "Modell's Sporting Goods":{
         "address":"234 W 42nd St, New York, NY 10036, United States",
         "phone":"+1 212-764-7030"
      }
   }
]
"""	// note the first line starts with a square bracket
let jsonData = Data(jsonString.utf8)

// JSON Model
struct Store: Codable {
	let address: String
	let phone: String?
}

// MARK: - JSON Parsing Function
func parseJSON(from data: Data) {
	let decoder = JSONDecoder()
	
	if let output = try? decoder.decode([String: Store].self, from: data) {
		print(output)
	}
}

parseJSON(from: jsonData)

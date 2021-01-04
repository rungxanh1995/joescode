// A simple app for Santa to say hi to kids
// It generates a random number that correlates to a list of gifts
// Then give these gifts to the kids

func SantaGifts(to kidName: (String) -> Void) {
  let names: Array = ["Joe", "Mon", "Rach", "Ross"]
  for name in names {
    kidName(name)
  }
}
SantaGifts { (name: String) in
  print("🎅🏻: Merry Xmas, \(name)! 🎄")
  let giftList: Array = [
    "iPhone",
    "iPod",
    "AirPods",
    "MacBook",
    "Apple Watch",
    "Apple Pencil"
  ]
  let secretGift: Int = Int.random(in: 0..<giftList.count)
  print("🎅🏻: You get the \(giftList[secretGift]) as your 🎁!")
}

// Sample results
// 🎅🏻: Merry Xmas, Joe! 🎄
// 🎅🏻: You get the Apple Pencil as your 🎁!
// 🎅🏻: Merry Xmas, Mon! 🎄
// 🎅🏻: You get the AirPods as your 🎁!
// 🎅🏻: Merry Xmas, Rach! 🎄
// 🎅🏻: You get the iPod as your 🎁!
// 🎅🏻: Merry Xmas, Ross! 🎄
// 🎅🏻: You get the AirPods as your 🎁!

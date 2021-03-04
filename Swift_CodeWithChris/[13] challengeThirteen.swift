// Challenge 13: Designated & Convenience Initializers

import Foundation

class Pets {
  var name:String = ""
  
  init() {
    name = "Doggo"
  }
  init(_ name:String) {
    self.name = name
  }
  func feed() {
    print("\(name) has been fed.")
  }
  func clean() {
    print("\(name) has taken a bath.")
  }
  func play() {
    print("\(name) enjoyed playing with you.")
  }
  func sleep() {
    print("\(name) went to sleep.")
  }
}

class Tamagotchi:Pets {
  var hunger:Int = 0
  var dirt:Int = 0
  var boredom:Int = 0
  var drowsiness:Int = 0
  var ageInDays:Double = 0
  var age:Double? { ageInDays / 30 }
  
  // Designated inherited init() from class Pets
  override init() {
    super.init()
    // Customize vars
    boredom = 60
    ageInDays = 0
  }
  // Convenience inherited init() from class Pets
  convenience override init(_ name:String) {
    // Redeclare self init() to make sure this func is ready to go
    self.init()
    // Customer var: takes in passed param
    self.name = name
  }
  
  override func feed() {
    if hunger == 0 {
      print("\(name) is already full.")
    } else {
      super.feed()
      hunger = 0
      boredom += 20
      dirt += 20
      drowsiness += 10
    }
  }
  override func clean() {
    if dirt == 0 {
      print("\(name) is already clean.")
    } else {
      super.clean()
      dirt = 0
      hunger += 20
      boredom += 20
      drowsiness += 10
    }
  }
  override func play() {
    if boredom == 0 {
      print("\(name) is already done playing.")
    } else {
      super.play()
      boredom = 0
      hunger += 20
      dirt += 20
      drowsiness += 10
    }
  }
  override func sleep() {
    if drowsiness == 0 {
      print("\(name) has already slept.")
    } else {
      super.sleep()
      ageInDays += 1
      drowsiness = 0
      boredom += 20
      hunger += 20
      dirt += 10
    }
  }
  func getAge() {
    print("\(name) is \(age!) months old.")
  }
  func check() {
    print("Hunger \(hunger) : Dirt \(dirt) : Boredom \(boredom) : Drowsiness \(drowsiness)")
    if hunger >= 60 {
      print("\(name) is hungry.")
    }
    if dirt >= 60 {
      print("\(name) is dirty.")
    }
    if boredom >= 60 {
      print("\(name) is bored.")
    }
    if drowsiness >= 60 {
      print("\(name) is sleepy.")
    }
  }
}
var pet = Tamagotchi()
print(pet.name)
pet.name = "Mích"
print(pet.name)

for _ in 1...90 {
  pet.play()
  pet.clean()
  pet.feed()
  pet.sleep()
}
pet.check()
pet.getAge()

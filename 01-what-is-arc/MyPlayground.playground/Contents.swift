import UIKit


//:### Pass by Value (STRUCTURE)
/*
var string1 = "Hello, playground"
var string2 = string1
 

if string1 == string2 {
    print("\(string1) is equal to \(string2)")
} else {
    print("\(string1) is NOT equal to \(string2)")
}
*/


//:### Pass by Reference (CLASS)

class Person {
    var first: String
    var last: String
    
    init(first: String, last: String) {
        self.first = first
        self.last = last
    }
}

let lucas = Person(first: "John", last: "Lucas")
lucas.first // "John"
lucas.last // "Lucas"

let chabby = lucas
chabby.first // "John"
chabby.first // "Lucas"

chabby.first = "Chabby"
chabby.first // "Chabby"
lucas.first // "Chabby"


//: ARC (Automatic Reference Counting)
class Device {
    let model: String
    let manufacturer: String
    
    init(model: String, manufacture: String) {
        self.model = model
        self.manufacturer = manufacture
    }
    
    deinit {
        print("\(model) is now deallocated")
    }
}

var lucasDevice: Device?
var chabbyDevice: Device?

lucasDevice = Device(model: "iPhone 12 Pro Max", manufacture: "Apple")
chabbyDevice = lucasDevice

//lucasDevice = nil
//chabbyDevice = nil

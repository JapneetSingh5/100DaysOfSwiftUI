import UIKit

var str = "Hello, playground"

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()

protocol Identifiable2 {
    var id: String { get set }
    func identify()
}

struct User: Identifiable2 {
    var id: String
    //to conform to the protocol, all properties must be present according to the protocol, methods are automatically provided ig
}

extension Identifiable2 {
    func identify() {
        print("My ID is \(id).")
    }
}

let twostraws = User(id: "twostraws")
twostraws.identify()

protocol Purchaseable {
    var name: String { get set }
}

struct Book: Purchaseable {
    var name: String
    var author: String
}

struct Movie: Purchaseable {
    var name: String
    var actors: [String]
}

struct Car: Purchaseable {
    var name: String
    var manufacturer: String
}

struct Coffee: Purchaseable {
    var name: String
    var strength: Int
}



//declaring Protocol even after defining types that conform to it works lol, nice touch, like JavaScript
//nope lol, doesnt work, sorry Future japneer

func buy(_ item: Purchaseable) {
    print("I'm buying \(item.name)")
}

protocol Product {
    var price: Double { get set }
    var weight: Int { get set }
}

protocol Computer : Product {
    var memory : Int { get set }
    var storage : Int { get set }
    var cpu: String { get set }
}

protocol Laptop: Computer {
    var screenSize: Int { get set }
}

//adding Product as a super Protocol here is redundant as Computer already conforms to Product, hence the warning : Redundant conformance constraint 'Self': 'Product

protocol SmartPhone {
    func makeCall(to name: String)
}
extension SmartPhone {
    func makeCall(to name: String) {
        print("Dialling \(name)...")
    }
}

protocol SuperHeroMovie {
    func writeScript() -> String
}
extension SuperHeroMovie {
    func makeScript() -> String {
        return """
        Lots of special effects,
        some half-baked jokes,
        and a hint of another
        sequel at the end.
        """
    }
}
protocol CanFly {
    var maximumFlightSpeed: Int { get set }
}
protocol CanDrive {
    var maximumDrivingSpeed: Int { get set }
}
struct FlyingCar: CanFly, CanDrive {
    var maximumFlightSpeed: Int
    
    var maximumDrivingSpeed: Int
}

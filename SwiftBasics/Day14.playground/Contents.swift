import UIKit

var str = "Hello, playground"

enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

//WeatherType is the type of argument, enums essentially define a type
func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus(weather: .wind(speed: 5)) //No WeatherType.wind as Swift type inferences easily


struct Person {
    var clothes: String
    var shoes: String
}

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")

var taylorCopy = taylor
taylorCopy.shoes = "flip flops"

print(taylor)
print(taylorCopy)

func hello(_ name: String){
    print("Hello \(name)")
}

func hello(_ name1:String, _ name2:String){
    print("Hello \(name1) and \(name2)")
}

hello("Maria")

hello("Maria","Mary")

func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }

    return nil
}

var year = yearAlbumReleased(name: "Red")

if year == nil {
    print("There was an error")
} else {
    print("It was released in \(year!)")
}

//Notice the year! variable, it is forced unwrapping of the optional
//That gets the year an album was released. If the album couldn't be found, year will be set to nil, and an error message will be printed. Otherwise, the year will be printed.
//
//Or will it? Well, yearAlbumReleased() returns an optional integer, and this code doesn't use if let to unwrap that optional. As a result, it will print out the following: "It was released in Optional(2012)" – probably not what we wanted!
//
//At this point in the code, we have already checked that we have a valid value, so it's a bit pointless to have another if let in there to safely unwrap the optional. So, Swift provides a solution – change the second print() call to this:

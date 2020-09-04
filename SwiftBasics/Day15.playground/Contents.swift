import UIKit

var str = "Hello, playground"


struct Person {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }

        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts")
taylor.clothes = "short skirts"


struct Person2 {
    var age: Int

    var ageInDogYears: Int {
        get {
            return age * 7
        }
    }
}

var fan = Person2(age: 25)
print(fan.ageInDogYears)

//Note :  If you only want to read the data, the get part can be removed entirely, ie:
//var ageInDogYears: Int {
//    return age * 7
//}


class TaylorFan {
    var age = 8
    static var favoriteSong = "Look What You Made Me Do"
    static func printSong(){
        print(favoriteSong)
//        print(age) //Instance member 'age' cannot be used on type 'TaylorFan'
    }
}

let fan2 = TaylorFan()
print(TaylorFan.favoriteSong)
TaylorFan.printSong()


class Album {
    var name: String

    init(name: String) {
        self.name = name
    }

    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String

    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String

    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}


var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
}


let number = 5
let text = String(number)
print(text)

func makeSale(signContract: (String, String) -> Void) {
    let clientName = "Apple"
    print("\(clientName) should buy our product.")
    print("You're interested? Great! Sign here.")
    signContract(clientName, clientName)
}
makeSale { (client: String, client2: String) in
    print("We agree to pay you $100 million.")
    print("Signed, \(client) \(client2)")
}

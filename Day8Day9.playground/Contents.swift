import UIKit

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
    
    mutating func updateAmountComplete(){   // Mark method 'mutating' to make, func has to be marked mutating to be able to mutate properties
       amount=100
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()

let person2 = Person(name: "Constantine")
//person2.makeAnonymous() //throws Error Cannot use mutating member on immutable value: 'person2' is a 'let' constant


let string = "Do or do not, there is no try."

print(string.customMirror)

print(string.description)

print(string.count)

let stringEmoji = "👨‍❤️‍👨"

print(stringEmoji.count)

print(stringEmoji.description)

print(stringEmoji.dropLast(1))

var toys = ["Woody"]

toys.remove(at: 0)
toys = ["buzz"]

print(toys.firstIndex(of: "Buzz") ?? -1)

print(toys)


struct User{
    var username: String
    
    init(){
        username = "Anonymous"
        print("Creating a new user!")
    }
}

//var user = User(username: "japneetsingh5")
//error: Argument passed to call that takes no arguments

//correct way:
var user = User()
print(user.username)
user.username = "singhjapneet5"
print(user.username)


//default values for properties

struct Employee {
    var name: String
    var yearsActive = 0
}

let roslin = Employee(name: "Laura Roslin")
let adama = Employee(name: "William Adama", yearsActive: 45)


//extensions

struct Employee2 {
    var name: String
    var yearsActive = 0
}

extension Employee2 {
    init() {
        name = "Anonymous"
        print("Creating an anonymous employee…")
    }
}

// creating a named employee now works
let roslin2 = Employee2(name: "Laura Roslin")

// as does creating an anonymous employee
let anon = Employee2()


struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct Person3 {
    var name: String
    lazy var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

var ed = Person3(name: "Ed")

print(ed.familyTree)

var ed2 = Person3(name: "Ed2")

print(ed2.familyTree) //ed2 cant be a constant, has to be var
//Cannot use mutating getter on immutable value: 'ed2' is a 'let' constant
//Because lazy properties change the underlying object they are attached to, you can’t use them on constant structs.

struct Person4 {
    private var id: String

    init(id: String) {
        self.id = id
    }

    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let ed4 = Person4(id: "ABCD")

//print(ed4.id)
//id' is inaccessible due to 'private' protection level


struct Code {
    var language: String
    var containsErrors = false
    var report: String {
        if containsErrors {
            return "This \(language) code has bugs!"
        } else {
            return "This looks good to me."
        }
    }
}

//Computed property must have an explicit type
//Constants cannot be computed properties.

struct FootballMatch {
    var homeTeamScore: Int {
        didSet {
            print("Yay - we scored!")
        }
    }
    var awayTeamScore: Int { //'let' declarations cannot be observing properties
        //property observers cannot be used for constant parameters
        didSet {
            print("Boo - they scored!")
        }
    }
}

//struct Tree {
//    var height: Int
//    mutating func grow() {
//        height *= 1.001
//    }
//}
// This (above) code attempts to multiply an Int by a Double, which is not allowed.

let tens = [30, 20, 10]
print(tens.sorted())

//tens.sort() .sort() mutates, hence wont work on a constant array

struct PlayingCards {
    static let deckSize: Int = 0
    var pictureStyle: String
}

struct Cat {
    static var allCats = [Cat]()
    init() {
        Cat.allCats.append(self)
    }
    static func chorus() {
        for _ in allCats {
            print("Meow!")
        }
    }
}

var cat = Cat()

print(Cat.allCats)

struct Doctor {
    var name: String
    var location: String
    private var currentPatient = "No one"
    init(name: String, location: String){
        self.name = name
        self.location = location
    }
}
let drJones = Doctor(name: "Esther Jones", location: "Bristol")
//This has a private property, so Swift is unable to generate its memberwise initializer for us.
//hence, we have to make a custom init() to bypass this restriction

struct School {
    var staffNames: [String]
    private var studentNames: [String]
    init(staff: String...) {
        self.staffNames = staff
        self.studentNames = [String]()
    }
}
let royalHigh = School(staff: "Mrs Hughes")

//nice example of a variadic initializer init() ^^

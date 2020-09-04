import UIKit

var str = "Hello, playground"

print(10/2.0)
//print("your age" + 26) error
//print(false+false) error
print(10+1.0)
let first = 12
let second = 4
let total = first + second
let product = first*second
let difference = first - second
let divide = first / second
let mod = first%second
let mod2 = 13%7
42 + 42.0
let fakers = "Fakers goonna "
let string2 = "Fake Fake fake Fake "
fakers + string2

//strings can be added as above

//arrays can be added too, kaafi cool of Swift to do this

let firstHalf = ["DC","RCB"]
let secondHalf = ["RR","KKR"]
let totalArray = firstHalf + secondHalf

var mutable = 6
mutable += 3
mutable -= 9

mutable *= 67

//totalArray += ["CSK, Thala!"] Doesnt work lol

"A"<"A"
//Strings have a natural order too??//////

"Taylor" < "Swift"

let FirstCard = 10
let SecondCard = 11

if FirstCard + SecondCard == 21 && FirstCard == 10
{
    print("21 22")
    
}

else {
    print ( "Sorry 22")
}

//Rarely used ternary operator flexing below ~~
print( FirstCard == SecondCard ? "Same aa 22" : "Cards arent same 22" )


let weather = "pata ni"

switch weather {
    case "pata ni" :
    print("fir mai ki dassa bro")
    fallthrough
case "rain" :
    print("umbrealla laele 22")
case "sunny" :
    print("sunscreen laale 22")

default:
    print("hehehe mazze")
}

//siwft is cool, no break required after every step only fallthrough where you need lolol, but only fallthroughs to the next case, if next case doesnt have a fallthrough it wont fallthrough intelligent logixx nice man cool yeahhh

1...3

1..<40

let score = 100

switch score {
case 1..<33 : print("fail hogya ae 22")
case 33 : print("massa i pass hoya ae 22")
case 34..<85:
    print("good bro nice1")
case 86..<100:
    print("chakk ta 22")
case 100:
    print("waah bro not bad")
default:
    print("marks taa dass mainu pehla bro")
}

//closed set layi 3 dots ...
//for exclusive set 2 dots + sign ie ..<, lower bounded included in both

1.5..<2
//range not necessarily integers huh

//var actualWage: Int = 22_000
//var medianWage: Double = 22_000
//if actualWage >= medianWage {
//    print("Success")
//}
//
//2.0 == 2

//different types cannot be compared

//Combining conditions is written as || with two pipe symbols, not | with one.

//switch statements MUST be exhaustive ie use default or *LIST ALL POSSIBLE VALUES* DNAG DANG
//case keyword is omitted for default ie only default: is written
// <> is not available as an operator in swift

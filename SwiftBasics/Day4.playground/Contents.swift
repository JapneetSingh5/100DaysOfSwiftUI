import UIKit

var str = "Hello, playground"

let count = 1...10

for count in count {
    print(count)
}

for _ in count {
    print("This will repeat 10 times")
}

let nums = [1,2,2,2,2,2,2,2]

for num in nums{
    print(num)
}

var number = 1
while number<=20 {
    print(number)
    
    if number == 4
    {
        print("khatam jaldi kardiya")
        break
    }
    
    number += 1
    
    
}

var number1 = false
repeat{
    print(number1)
}while number1

while number1{
    print(number1)
}


outerLoop : for i in 1...10
{for j in 1...10
{if i*j == 50
        {break outerLoop}
    print("\(i) * \(j) is \(i*j)")}}


var counter = 0

while true {
    print(" ")
    counter += 1

    if counter == 273 {
        break
    }
}



//Loops let us repeat code until a condition is false.
//The most common loop is for, which assigns each item inside the loop to a temporary constant.
//If you don’t need the temporary constant that for loops give you, use an underscore instead so Swift can skip that work.
//There are while loops, which you provide with an explicit condition to check.
//Although they are similar to while loops, repeat loops always run the body of their loop at least once.
//You can exit a single loop using break, but if you have nested loops you need to use break followed by whatever label you placed before your outer loop.
//You can skip items in a loop using continue.
//Infinite loops don’t end until you ask them to, and are made using while true. Make sure you have a condition somewhere to end your infinite loops!


//Oops – that's not correct. You cannot loop over a tuple like this.

var population = 7_500_000_000
repeat {
    print("More babies have been born.")
    population *= 1.0001
} while true

//int and double can not be multiplied together huh sml ki tarah

//
// Control-Flow.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation

//: # 控制流
/*:
 `Swift` 提供了多种流程控制结构，包括 `while` 循环，条件控制 `if`、`guard` 和 `switch` 语句，还有控制流程跳转的 `break` 和 `continue` 语句。
 
 `Swift` 还提供了 `for-in` 循环，用来更简单地遍历数组 `Array` ，字典 `Dictionary` ，区间 `Range` ，字符串 `String` 和其他序列类型。
 
 `Swift` 的 `switch` 语句比 `C` 语言中更加强大。`case` 可以匹配很多不同的模式，包括范围匹配，元组 `tuple` 和特定类型匹配。`switch` 语句的 `case` 中匹配的值可以声明为临时常量或变量，在 `case` 作用域内使用，也可以配合 `where` 来描述更复杂的匹配条件。
 */

//: ## For-In 循环
/*:
 `Swift` 中使用 for-in 循环来遍历一个集合中的所有元素：
 
     let names = ["Anna", "Alex", "Brian", "Jack"]
     for name in names {
         print("Hello, \(name)!")
     }
     // Hello, Anna!
     // Hello, Alex!
     // Hello, Brian!
     // Hello, Jack!
 
 遍历字典，字典的每项元素会以 (`key`, `value`) 元组的形式返回，可以在 `for-in` 循环中使用显式的常量名称来解读 (`key`, `value`) 元组：
 
     let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
     for (animalName, legCount) in numberOfLegs {
         print("\(animalName)s have \(legCount) legs")
     }
     // ants have 6 legs
     // spiders have 8 legs
     // cats have 4 legs
 
 遍历区间：
 
     for index in 1...5 {
         print("\(index) times 5 is \(index * 5)")
     }
     // 1 times 5 is 5
     // 2 times 5 is 10
     // 3 times 5 is 15
     // 4 times 5 is 20
     // 5 times 5 is 25
 
 */

//: ## While 循环
/*:
 `while` 循环会一直运行一段语句直到条件变成 `false` 。`Swift` 提供两种 `while` 循环形式：
 
 - `while` 循环，每次在循环开始时计算条件是否符合；
 
         while condition {
             statements
         }
 
 - `repeat-while` 循环，每次在循环结束时计算条件是否符合。
 
         repeat {
             statements
         } while condition
 
 */

//: ## 条件判断
/*:
 `Swift` 提供两种类型的条件语句：`if` 语句和 `switch` 语句。当条件较为简单且可能的情况很少时，使用 `if` 语句。 `switch` 语句适用于条件较复杂、有更多排列组合的时候， `switch` 还可以使用复杂的模式匹配（`pattern-matching`）。
 - `if` 语句最简单的形式就是只包含一个条件，只有该条件为 `true` 时，才执行相关代码：
 
         var temperatureInFahrenheit = 30
         if temperatureInFahrenheit <= 32 {
             print("It's very cold. Consider wearing a scarf.")
         }
         // 输出 "It's very cold. Consider wearing a scarf."
 
 - `switch` 语句会尝试把值与若干个模式（`pattern`）进行匹配。 `switch` 语句会执行第一个匹配成功的 `case` 的代码：
 
         switch some value to consider {
         case value 1:
             respond to value 1
         case value 2, value 3:
             respond to value 2 or 3
         default:
             otherwise, do something else
         }
 
 `switch` 语句必须是完备的，当 `case` 无法穷举时，必须提供 `default` 分支。 `switch` 中的 `case` 必须至少包含一条语句。
 
     let anotherCharacter: Character = "a"
     switch anotherCharacter {
     case "a": // 无效，这个分支下面没有语句
     case "A":
         print("The letter A")
     default:
         print("Not the letter A")
     }
     // 这段代码会报编译错误
 */

//: ### 不存在隐式的贯穿
/*:
 `Swift` 中 `switch` `case` 中不需要显式的 `break`，`Swift` 中 `switch` 在执行完毕 `case` 之后会默认 `break` ，若需要自动流转到下一个 `case` 则需要使用 `fallthrough` 关键词！
 */

//: ### 模式匹配：区间
/*:
 `case` 分支的模式可以是一个值的区间：
 
     let approximateCount = 62
     let countedThings = "moons orbiting Saturn"
     let naturalCount: String
     switch approximateCount {
     case 0:
         naturalCount = "no"
     case 1..<5:
         naturalCount = "a few"
     case 5..<12:
         naturalCount = "several"
     case 12..<100:
         naturalCount = "dozens of"
     case 100..<1000:
         naturalCount = "hundreds of"
     default:
         naturalCount = "many"
     }
     print("There are \(naturalCount) \(countedThings).")
     // 输出 "There are dozens of moons orbiting Saturn."
 
 */

//: ### 模式匹配：元组
/*:
 `case` 可以使用元组在同一个 `switch` 语句中测试多个值。元组中的元素可以是值，也可以是区间。使用下划线（_）来进行通配：
 
     let somePoint = (1, 1)
     switch somePoint {
     case (0, 0):
         print("\(somePoint) is at the origin")
     case (_, 0):
         print("\(somePoint) is on the x-axis")
     case (0, _):
         print("\(somePoint) is on the y-axis")
     case (-2...2, -2...2):
         print("\(somePoint) is inside the box")
     default:
         print("\(somePoint) is outside of the box")
     }
     // 输出 "(1, 1) is inside the box"
 
 */

//: ### 模式匹配：`where`
/*:
 `case` 分支的模式可以使用 `where` 语句来判断额外的条件：
 
     let yetAnotherPoint = (1, -1)
     switch yetAnotherPoint {
     case let (x, y) where x == y:
         print("(\(x), \(y)) is on the line x == y")
     case let (x, y) where x == -y:
         print("(\(x), \(y)) is on the line x == -y")
     case let (x, y):
         print("(\(x), \(y)) is just some arbitrary point")
     }
     // 输出 "(1, -1) is on the line x == -y"
 
 */

//: ### 模式匹配：复合型case
/*:
 当多个条件可以使用同一种方法来处理时，可以将这几种可能放在同一个 `case` 后面，并且用逗号隔开。当 `case` 后面的任意一种模式匹配的时候，这条分支就会被匹配。并且，如果匹配列表过长，还可以分行书写：
 
     let someCharacter: Character = "e"
     switch someCharacter {
     case "a", "e", "i", "o", "u":
         print("\(someCharacter) is a vowel")
     case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
         print("\(someCharacter) is a consonant")
     default:
         print("\(someCharacter) is not a vowel or a consonant")
     }
     // 输出 "e is a vowel"
 
 */

//: ## 流程跳转
/*:
 控制转移语句改变代码的执行顺序，通过它可以实现代码的跳转。`Swift` 有五种控制转移语句：
 - `continue`：告诉一个循环体立刻停止本次循环，重新开始下次循环
 
         let puzzleInput = "great minds think alike"
         var puzzleOutput = ""
         for character in puzzleInput {
             switch character {
             case "a", "e", "i", "o", "u", " ":
                 continue
             default:
                 puzzleOutput.append(character)
             }
         }
         print(puzzleOutput)
         // 输出 "grtmndsthnklk"
 
 - `break`：立刻结束整个控制流的执行
 
         let numberSymbol: Character = "三"  // 简体中文里的数字 3
         var possibleIntegerValue: Int?
         switch numberSymbol {
         case "1", "١", "一", "๑":
             possibleIntegerValue = 1
         case "2", "٢", "二", "๒":
             possibleIntegerValue = 2
         case "3", "٣", "三", "๓":
             possibleIntegerValue = 3
         case "4", "٤", "四", "๔":
             possibleIntegerValue = 4
         default:
             break
         }
         if let integerValue = possibleIntegerValue {
         print("The integer value of \(numberSymbol) is \(integerValue).")
         } else {
         print("An integer value could not be found for \(numberSymbol).")
         }
         // 输出 "The integer value of 三 is 3."
 
 - `fallthrough`：在 `Swift` 里，`switch` 语句不会从上一个 `case` 分支跳转到下一个 `case` 分支中，使用 `fallthrough` 可以让代码自动跳到下一个 `case` 执行：
 
         let integerToDescribe = 5
         var description = "The number \(integerToDescribe) is"
         switch integerToDescribe {
         case 2, 3, 5, 7, 11, 13, 17, 19:
             description += " a prime number, and also"
             fallthrough
         default:
             description += " an integer."
         }
         print(description)
         // 输出 "The number 5 is a prime number, and also an integer."
 
 - `return`
 - `throw`
 */

//: ## 提前退出
/*:
 `guard` 语句类似 `if` 语句但有所区别， `guard` 语句当条件为真时执行 `guard` 语句后的代码， `guard` 语句总是有一个 `else` 分支，如果条件为假则执行 `else` 从句中的代码：
 
     func greet(person: [String: String]) {
         guard let name = person["name"] else {
             return
         }
         print("Hello \(name)")
         guard let location = person["location"] else {
         print("I hope the weather is nice near you.")
             return
         }
         print("I hope the weather is nice in \(location).")
     }
     greet(["name": "John"])
     // 输出 "Hello John!"
     // 输出 "I hope the weather is nice near you."
     greet(["name": "Jane", "location": "Cupertino"])
     // 输出 "Hello Jane!"
     // 输出 "I hope the weather is nice in Cupertino."
 
 */

//: ## 检测 API 可用性
/*:
 `Swift` 内置支持检查 `API` 可用性，这可以确保我们不会在当前部署机器上，不小心地使用了不可用的 `API` ：
 
     if #available(iOS 10, macOS 10.12, *) {
         // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
     } else {
         // 使用先前版本的 iOS 和 macOS 的 API
     }
 
 */
//: [下一页](@next)

//
// Error-Handling.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 错误处理
/*:
 错误处理（Error handling）是响应错误以及从错误中恢复的过程。Swift 提供了在运行时对可恢复错误的抛出、捕获、传递和操作的一等公民支持。
 */

//: ## 表示并抛出错误
/*:
 在 Swift 中，错误用符合 Error 协议的类型的值来表示。这个空协议表明该类型可以用于错误处理。
 
 Swift 的枚举类型尤为适合构建一组相关的错误状态，枚举的关联值还可以提供错误状态的额外信息：
 
     enum VendingMachineError: Error {
         case invalidSelection                    //选择无效
         case insufficientFunds(coinsNeeded: Int) //金额不足
         case outOfStock                          //缺货
     }
 
 抛出错误使用 throw 关键字：
 
     throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
 
 */

//: ## 处理错误
/*:
 Swift 中有 4 种处理错误的方式。可以把函数抛出的错误传递给调用此函数的代码、用 do-catch 语句处理错误、将错误作为可选类型处理、或者断言此错误根本不会发生。在调用一个能抛出错误的函数、方法或者构造器之前，加上 try 关键字，或者 try? 或 try! 这种变体。
 
 Swift 中的错误处理和其他语言中用 try，catch 和 throw 进行异常处理很像。和其他语言中（包括 Objective-C ）的异常处理不同的是，Swift 中的错误处理并不涉及解除调用栈，这是一个计算代价高昂的过程。就此而言，throw 语句的性能特性是可以和 return 语句相媲美的。
 
 */

//: ## 用 throwing 函数传递错误
/*:
 表示一个函数、方法或构造器可以抛出错误，在函数声明的参数列表之后加上 throws 关键字即可。一个标有 throws 关键字的函数被称作throwing 函数。如果这个函数指明了返回值类型，throws 关键词需要写在箭头（->）的前面。
 
     func canThrowErrors() throws -> String
     func cannotThrowErrors() -> String
 
 一个 throwing 函数可以在其内部抛出错误，并将错误传递到函数被调用时的作用域。
 
 只有 throwing 函数可以传递错误。任何在某个非 throwing 函数内部抛出的错误只能在函数内部处理。
 
     struct Item {
         var price: Int
         var count: Int
     }
 
     class VendingMachine {
         var inventory = [
             "Candy Bar": Item(price: 12, count: 7),
             "Chips": Item(price: 10, count: 4),
             "Pretzels": Item(price: 7, count: 11)
         ]
         var coinsDeposited = 0
         func dispenseSnack(snack: String) {
             print("Dispensing \(snack)")
         }
 
         func vend(itemNamed name: String) throws {
             guard let item = inventory[name] else {
                 throw VendingMachineError.invalidSelection
             }
 
             guard item.count > 0 else {
                 throw VendingMachineError.outOfStock
             }
 
             guard item.price <= coinsDeposited else {
                 throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
             }
 
             coinsDeposited -= item.price
 
             var newItem = item
             newItem.count -= 1
             inventory[name] = newItem
 
             print("Dispensing \(name)")
         }
     }
 
     let favoriteSnacks = [
         "Alice": "Chips",
         "Bob": "Licorice",
         "Eve": "Pretzels",
     ]
     func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
         let snackName = favoriteSnacks[person] ?? "Candy Bar"
         try vendingMachine.vend(itemNamed: snackName)
     }
 
 throwing 构造器能像 throwing 函数一样传递错误：
 
     struct PurchasedSnack {
         let name: String
         init(name: String, vendingMachine: VendingMachine) throws {
             try vendingMachine.vend(itemNamed: name)
             self.name = name
         }
     }
 
 */

//: ## 用 Do-Catch 处理错误
/*:
 可以使用一个 do-catch 语句运行一段闭包代码来处理错误。如果在 do 子句中的代码抛出了一个错误，这个错误会与 catch 子句做匹配：
 
     do {
         try expression
         statements
     } catch pattern 1 {
         statements
     } catch pattern 2 where condition {
         statements
     }
 
 在 catch 后面写一个匹配模式来匹配错误类型。如果一条 catch 子句没有指定匹配模式，那么这条子句可以匹配任何错误，并且把错误绑定到一个名字为 error 的局部常量。catch 子句不必将 do 子句中的代码所抛出的每一个可能的错误都作处理。
 
     var vendingMachine = VendingMachine()
     vendingMachine.coinsDeposited = 8
     do {
         try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
     } catch VendingMachineError.invalidSelection {
         print("Invalid Selection.")
     } catch VendingMachineError.outOfStock {
         print("Out of Stock.")
     } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
         print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
     }
     // 打印 “Insufficient funds. Please insert an additional 2 coins.”
 
 */

//: ## 将错误转换成可选值
/*:
 可以使用 try? 通过将错误转换成一个可选值来处理错误。如果在执行 try? 表达式时一个错误被抛出，那么表达式的值就是 nil：
 
     func someThrowingFunction() throws -> Int {
         // ...
     }
 
     let x = try? someThrowingFunction()
 
     let y: Int?
     do {
         y = try someThrowingFunction()
     } catch {
         y = nil
     }
 
 */

//: ## 强制解包错误
/*:
 当某个 throwing 函数实际上在运行时是不会抛出错误时，可以在表达式前面写 try! 来进行强制解包错误，这会把调用包装在一个不会有错误抛出的运行时断言中。如果真的抛出了错误，你会得到一个运行时错误。
 
     let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg"
 
 */

//: ## 函数退出WatchDog
/*:
 可以使用 defer 语句在即将离开当前代码块时执行一系列语句。该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的——无论是由于抛出错误而离开，或是由于诸如 return、break 的语句。例如，你可以用 defer 语句来确保文件描述符得以关闭，以及手动分配的内存得以释放。
 
 defer 语句将代码的执行延迟到当前的作用域退出之前，延迟执行的操作会按照它们声明的顺序从后往前执行：
 
     func processFile(filename: String) throws {
         if exists(filename) {
             let file = open(filename)
         defer {
             close(file)
         }
         while let line = try file.readline() {
             // 处理文件。
         }
         // close(file) 会在这里被调用，即作用域的最后。
         }
     }
 
 */
//: [下一页](@next)

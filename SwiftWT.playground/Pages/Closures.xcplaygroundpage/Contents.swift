//
// Closures.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation

//: # 闭包
/*:
 闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块（blocks）以及其他一些编程语言中的 lambdas 表达式比较相似。
 
 闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为**捕获**常量和变量。 Swift 会为你管理在捕获过程中涉及到的所有内存操作。
 
 在[函数](Functions)一节中介绍的全局和嵌套函数实际上也是特殊的闭包，闭包的三种形式：
 - 全局函数是一个有名字但不会捕获任何值的闭包
 - 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
 - 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
 
 Swift 的闭包表达式拥有简洁的风格，并鼓励在常见场景中进行语法优化，主要优化如下：
 
 - 利用上下文推断参数和返回值类型
 - 隐式返回单表达式闭包，即单表达式闭包可以省略 return 关键字
 - 参数名称缩写
 - 尾随闭包语法
 */

//: ## 闭包表达式
/*:
  闭包表达式是一种利用简洁语法构建内联闭包的方式。闭包表达式提供了一些语法优化，使得撰写闭包变得简单明了。
 
 ### 闭包表达式语法
 闭包表达式语法有如下的一般形式：
 
     { (parameters) -> return type in
         statements
     }
 
 闭包的参数、返回值的类型与函数的一致。闭包的函数体部分由关键字 in 引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。
 
 定义一个排序函数：
 
     func backward(_ s1: String, _ s2: String) -> Bool {
         return s1 > s2
     }
     var reversedNames = names.sorted(by: backward)
     // reversedNames 为 ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
 
 使用闭包的形式：
 
     reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
         return s1 > s2
     })
 
 简写在一行：
 
     reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
 
 ### 根据上下文推断类型
 Swift 中闭包可以根据调用的上下文对闭包的参数以及返回值的类型进行类型*推断*，上述的闭包可以简写为：
 
     reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
 
 ### 单表达式闭包隐式返回
 Swift 中单行闭包表达式可以隐藏返回关键词 `return`：
 
     reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
 
 ### 参数名称缩写
 Swift 自动为内联闭包提供了参数名称缩写功能，可以直接通过 $0，$1，$2 来顺序调用闭包的参数，以此类推：
 
     reversedNames = names.sorted(by: { $0 > $1 } )
 
 ### 运算符方法
 Swift 的 String 类型定义了关于大于号（>）的字符串实现，其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。而这正好与 sorted(by:) 方法的参数需要的函数类型相符合。因此，你可以简单地传递一个大于号，Swift 可以自动推断出你想使用大于号的字符串函数实现：
 
     reversedNames = names.sorted(by: >)
 
 */

//: ## 尾随闭包
/*:
 如果需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用*尾随闭包*来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，你不用写出它的参数标签：
 
     func someFunctionThatTakesAClosure(closure: () -> Void) {
         // 函数体部分
     }
 
     // 以下是不使用尾随闭包进行函数调用
     someFunctionThatTakesAClosure(closure: {
         // 闭包主体部分
     })
 
     // 以下是使用尾随闭包进行函数调用
     someFunctionThatTakesAClosure() {
         // 闭包主体部分
     }
 
 上述闭包可以改写为：
 
     reversedNames = names.sorted() { $0 > $1 }
 
 如果闭包表达式是函数或方法的唯一参数，当你使用尾随闭包时，甚至可以把 () 省略掉：
 
     reversedNames = names.sorted { $0 > $1 }
 
 */

//: ## 值捕获
/*:
 闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
 
 - Note:
 为了优化，如果一个值不会被闭包改变，或者在闭包创建后不会改变，Swift 可能会改为捕获并保存一份对值的拷贝。
 Swift 也会负责被捕获变量的所有内存管理工作，包括释放不再需要的变量。
 */

//: ## 逃逸闭包
/*:
 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，就称该闭包从函数中逃逸。定义接受闭包作为参数的函数时，通过在参数名之前标注 `@escaping`，用来指明这个闭包是允许“逃逸”出这个函数的：
 
     var completionHandlers: [() -> Void] = []
     func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
         completionHandlers.append(completionHandler)
     }
 
 函数参数引用逃逸闭包时必须显式标记 `@escaping` 否则会触发编译器报错。
 
 逃逸闭包必须在闭包内部显式引用 `self` ，非逃逸闭包则可以隐式的引用 `self` ：
 
     func someFunctionWithNonescapingClosure(closure: () -> Void) {
         closure()
     }
 
     class SomeClass {
         var x = 10
         func doSomething() {
             someFunctionWithEscapingClosure { self.x = 100 }
             someFunctionWithNonescapingClosure { x = 200 }
         }
     }
 
     let instance = SomeClass()
     instance.doSomething()
     print(instance.x)
     // 打印出 "200"
 
     completionHandlers.first?()
     print(instance.x)
     // 打印出 "100"
 
 */

//: ## 自动闭包
/*:
 自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式；自动闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值；自动便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
 
 例如，`assert(condition:message:file:line:)` 函数接受自动闭包作为它的 condition 参数和 message 参数；它的 condition 参数仅会在 debug 模式下被求值，它的 message 参数仅当 condition 参数为 false 时被计算求值。
 
 自动闭包能够延迟求值，直到调用这个闭包，代码段才会被执行。延迟求值对于那些有副作用（Side Effect）和高计算成本的代码来说是很有益处的，因为它使得你能控制代码的执行时机。下面的代码展示了闭包如何延时求值：
 
     var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
     print(customersInLine.count)
     // 打印出 "5"
 
     let customerProvider = { customersInLine.remove(at: 0) }
     print(customersInLine.count)
     // 打印出 "5"
 
     print("Now serving \(customerProvider())!")
     // Prints "Now serving Chris!"
     print(customersInLine.count)
     // 打印出 "4"
 
 将闭包作为参数传递给函数时，同样能获得延时求值的行为：
 
     // customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
     func serve(customer customerProvider: () -> String) {
     print("Now serving \(customerProvider())!")
     }
     serve(customer: { customersInLine.remove(at: 0) } )
     // 打印出 "Now serving Alex!"
 
 - Note:
 过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行的。
 */
//: [下一页](@next)

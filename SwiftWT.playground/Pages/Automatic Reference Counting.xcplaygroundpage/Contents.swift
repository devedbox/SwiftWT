//
// Automatic-Reference-Counting.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 自动引用计数
/*:
 Swift 使用自动引用计数（ARC）机制来跟踪和管理应用程序的内存。通常情况下，Swift 内存管理机制会一直起作用，无须自己来考虑内存的管理。ARC 会在类的实例不再被使用时，自动释放其占用的内存。
 
 - Note:
 引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递。
 */

//: ## 自动引用计数的机制
/*:
 当每次创建一个类的新的实例的时候，ARC 会分配一块内存来储存该实例信息。内存中会包含实例的类型信息，以及这个实例所有相关的存储型属性的值。
 
 当实例不再被使用时，ARC 释放实例所占用的内存，并让释放的内存能挪作他用。这确保了不再被使用的实例，不会一直占用内存空间。
 
 当 ARC 收回和释放了正在被使用中的实例，该实例的属性和方法将不能再被访问和调用。如果你试图访问这个实例，你的应用程序很可能会崩溃。
 
 为了确保使用中的实例不会被销毁，ARC 会跟踪和计算每一个实例正在被多少属性，常量和变量所引用。哪怕实例的引用数为1，ARC 都不会销毁这个实例。
 
 为了使上述成为可能，无论将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为“强”引用，是因为它会将实例牢牢地保持住，只要强引用还在，实例是不允许被销毁的。
 */

//: ## 类实例之间的循环强引用
/*:
 在实际情况中，我们可能会写出一个类实例的强引用数永远不能变成 0 的代码。如果两个类实例互相持有对方的强引用，每个实例都让对方一直存在，这种情况就是所谓的循环强引用。
 
 可以通过定义类之间的关系为弱引用或无主引用，以替代强引用，从而解决循环强引用的问题。
 */

//: ## 解决实例之间的循环强引用
/*:
 Swift 提供了两种办法用来解决在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference）和无主引用（unowned reference）。
 
 弱引用和无主引用允许循环引用中的一个实例引用而另外一个实例不保持强引用。这样实例能够互相引用而不产生循环强引用。
 
 当其他的实例有更短的生命周期时，使用弱引用;，当其他实例有相同的或者更长生命周期时，请使用无主引用。
 */
//: ### 弱引用
/*:
 弱引用不会对其引用的实例保持强引用，不会阻止 ARC 销毁被引用的实例。这个特性防止了引用变为循环强引用。声明属性或者变量时，在前面加上 weak 关键字表明这是一个弱引用。
 
 弱引用不会保持所引用的实例，即使引用存在，实例也有可能被销毁。因此，ARC 会在引用的实例被销毁后自动将其赋值为 nil。并且因为弱引用可以允许它们的值在运行时被赋值为 nil，所以它们会被定义为可选类型变量，而不是常量。
 
 可以像其他可选值一样，检查弱引用的值是否存在，你将永远不会访问已销毁的实例的引用。
 
 - Note:
 当 ARC 设置弱引用为 nil 时，属性观察不会被触发。
 
 示例：
 
     class Person {
         let name: String
         init(name: String) { self.name = name }
         var apartment: Apartment?
         deinit { print("\(name) is being deinitialized") }
     }
 
     class Apartment {
         let unit: String
         init(unit: String) { self.unit = unit }
         weak var tenant: Person?
         deinit { print("Apartment \(unit) is being deinitialized") }
     }
 
     var john: Person?
     var unit4A: Apartment?
 
     john = Person(name: "John Appleseed")
     unit4A = Apartment(unit: "4A")
 
     john!.apartment = unit4A
     unit4A!.tenant = john
 
     john = nil
     // 打印 "John Appleseed is being deinitialized"
 
     unit4A = nil
     // 打印 "Apartment 4A is being deinitialized"
 */

//: ## 无主引用
/*:
 和弱引用类似，无主引用不会牢牢保持住引用的实例。不同的是，无主引用在其他实例有相同或者更长的生命周期时使用。可以在声明属性或者变量时，在前面加上关键字 unowned 表示这是一个无主引用。
 
 无主引用通常都被期望拥有值。不过 ARC 无法在实例被销毁后将无主引用设为 nil，因为非可选类型的变量不允许被赋值为 nil。
 
 - Note:
 使用无主引用，你必须确保引用始终指向一个未销毁的实例。
 如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。
 
 示例：
 
     class Customer {
         let name: String
         var card: CreditCard?
         init(name: String) {
             self.name = name
         }
         deinit { print("\(name) is being deinitialized") }
     }
 
     class CreditCard {
         let number: UInt64
         unowned let customer: Customer
         init(number: UInt64, customer: Customer) {
             self.number = number
             self.customer = customer
         }
         deinit { print("Card #\(number) is being deinitialized") }
     }
 
     var john: Customer?
     john = Customer(name: "John Appleseed")
     john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)
 
     john = nil
     // 打印 "John Appleseed is being deinitialized"
     // 打印 "Card #1234567890123456 is being deinitialized"
 
 - Note:
 上面的例子展示了如何使用安全的无主引用。对于需要禁用运行时的安全检查的情况（例如，出于性能方面的原因），Swift 还提供了不安全的无主引用。与所有不安全的操作一样，需要负责检查代码以确保其安全性。 可以通过 unowned(unsafe) 来声明不安全无主引用。如果试图在实例被销毁后，访问该实例的不安全无主引用，你的程序会尝试访问该实例之前所在的内存地址，这是一个不安全的操作。
 */

//: ## 闭包的循环引用
/*:
 循环强引用还会发生在当将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时。这个闭包体中可能访问了实例的某个属性，例如 self.someProperty，或者闭包中调用了实例的某个方法，例如 self.someMethod()。这两种情况都导致了闭包“捕获”self，从而产生了循环强引用。
 
 在闭包中，Swift 提供了一种优雅的方法来解决这个问题，称之为 闭包捕获列表（closure capture list）。
 */

//: ## 解决闭包的循环强引用
/*:
 在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。
 */
//: ### 定义捕获列表
/*:
 捕获列表中的每一项都由一对元素组成，一个元素是 weak 或 unowned 关键字，另一个元素是类实例的引用（例如 self）或初始化过的变量（如 delegate = self.delegate!）。这些项在方括号中用逗号分开。如果闭包有参数列表和返回类型，把捕获列表放在它们前面：
 
     lazy var someClosure: (Int, String) -> String = {
     [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
         // 这里是闭包的函数体
     }
 
 如果闭包没有指明参数列表或者返回类型，它们会通过上下文推断，那么可以把捕获列表和关键字 in 放在闭包最开始的地方：
 
     lazy var someClosure: Void -> String = {
     [unowned self, weak delegate = self.delegate!] in
         // 这里是闭包的函数体
     }
 
 */

//: ### 弱引用和无主引用
/*:
 在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为 无主引用。
 
 在被捕获的引用可能会变为 nil 时，将闭包内的捕获定义为 弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为 nil。这使我们可以在闭包体内检查它们是否存在。
 
 - Note:
 如果被捕获的引用绝对不会变为 nil，应该用无主引用，而不是弱引用。
 */
//: [下一页](@next)

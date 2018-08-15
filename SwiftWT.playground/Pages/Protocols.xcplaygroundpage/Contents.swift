//
// Protocols.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 协议
/*:
 **协议**定义了一系列用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西。类、结构体或枚举都可以遵循协议，并为协议定义的这些要求提供具体实现。某个类型能够满足某个协议的要求，就可以说该类型遵循这个协议。
 
 除了遵循协议的类型必须实现的要求外，还可以对协议进行扩展，通过扩展来实现一部分要求或者实现一些附加功能，这样遵循协议的类型就能够使用这些功能。
 */

//: ## 协议语法
/*:
 协议的定义方式与类、结构体和枚举的定义非常相似：
 
     protocol SomeProtocol {
         // 这里是协议的定义部分
     }
 
 让自定义类型遵循某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号（:）分隔。遵循多个协议时，各协议之间用逗号（,）分隔：
 
     struct SomeStructure: FirstProtocol, AnotherProtocol {
         // 这里是结构体的定义部分
     }
 
 拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔：
 
     class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
         // 这里是类的定义部分
     }
 
 */

//: ## 属性
/*:
 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的。
 
 如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性。如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果代码需要的话，还可以是可写的。
 
 协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get } 来表示：
 
     protocol SomeProtocol {
         var mustBeSettable: Int { get set }
         var doesNotNeedToBeSettable: Int { get }
     }
 
 在协议中定义类型属性时，使用 static 关键字作为前缀即可。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性：
 
     protocol AnotherProtocol {
         static var someTypeProperty: Int { get set }
     }
 
 示例：
 
     protocol FullyNamed {
         var fullName: String { get }
     }
 
 实现协议：
 
     struct Person: FullyNamed {
         var fullName: String
     }
     let john = Person(fullName: "John Appleseed")
     // john.fullName 为 "John Appleseed"
 
     class Starship: FullyNamed {
         var prefix: String?
         var name: String
         init(name: String, prefix: String? = nil) {
             self.name = name
             self.prefix = prefix
         }
         var fullName: String {
             return (prefix != nil ? prefix! + " " : "") + name
         }
     }
     var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
     // ncc1701.fullName 是 "USS Enterprise"
 
 */

//: ## 方法
/*:
 协议可以声明实例方法和类方法。定义函数的时候只需要声明而不需要实现。可以定义可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法的参数提供默认值。
 
 在协议中定义类方法的时候，使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字作为前缀：
 
     protocol SomeProtocol {
         static func someTypeMethod()
     }
 
 示例：
 
     protocol RandomNumberGenerator {
         func random() -> Double
     }
 
     protocol Togglable {
         mutating func toggle()
     }
 
 实现协议：
 
     class LinearCongruentialGenerator: RandomNumberGenerator {
         var lastRandom = 42.0
         let m = 139968.0
         let a = 3877.0
         let c = 29573.0
         func random() -> Double {
             lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
             return lastRandom / m
         }
     }
     let generator = LinearCongruentialGenerator()
     print("Here's a random number: \(generator.random())")
     // 打印 “Here's a random number: 0.37464991998171”
     print("And another one: \(generator.random())")
     // 打印 “And another one: 0.729023776863283”
 
     enum OnOffSwitch: Togglable {
         case off, on
         mutating func toggle() {
             switch self {
             case .off:
                 self = .on
             case .on:
                 self = .off
             }
         }
     }
     var lightSwitch = OnOffSwitch.off
     lightSwitch.toggle()
     // lightSwitch 现在的值为 .on
 */

//: ## 构造器
/*:
 协议可以要求遵循协议的类型实现指定的构造器：
 
     protocol SomeProtocol {
         init(someParameter: Int)
     }
 
 ### 使用类实现构造器
 可以在遵循协议的类中实现构造器，无论是指定构造器，还是便利构造器，都必须为构造器实现标上 required 修饰符：
 
     class SomeClass: SomeProtocol {
         required init(someParameter: Int) {
             // 这里是构造器的实现部分
         }
     }
 
 - Note:
 如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不能有子类。
 如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标注 required 和 override 修饰符：
         protocol SomeProtocol {
             init()
         }
 
         class SomeSuperClass {
             init() {
                 // 这里是构造器的实现部分
             }
         }
 
         class SomeSubClass: SomeSuperClass, SomeProtocol {
             // 因为遵循协议，需要加上 required
             // 因为继承自父类，需要加上 override
             required override init() {
                 // 这里是构造器的实现部分
             }
         }
 
 */

//: # 可失败构造器
/*:
 协议还可以为遵循协议的类型定义可失败构造器：
 
 遵循协议的类型可以通过可失败构造器（init?）或非可失败构造器（init）来实现协议中定义的可失败构造器。协议中定义的非可失败构造器可以通过非可失败构造器（init）或隐式解包可失败构造器（init!）来实现
 */

//: ## 协议作为类型
/*:
 协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用。
 
 协议可以像其他普通类型一样使用，使用场景如下：
 - 作为函数、方法或构造器中的参数类型或返回值类型
 - 作为常量、变量或属性的类型
 - 作为数组、字典或其他容器中的元素类型
 
 示例：
 
     class Dice {
         let sides: Int
         let generator: RandomNumberGenerator
         init(sides: Int, generator: RandomNumberGenerator) {
             self.sides = sides
             self.generator = generator
         }
         func roll() -> Int {
             return Int(generator.random() * Double(sides)) + 1
         }
     }
 
     var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
     for _ in 1...5 {
         print("Random dice roll is \(d6.roll())")
     }
     // Random dice roll is 3
     // Random dice roll is 5
     // Random dice roll is 4
     // Random dice roll is 5
     // Random dice roll is 4
 
 */

//: ## 扩展里实现协议
/*:
 可以通过扩展令已有类型遵循并符合协议。扩展可以为已有类型添加属性、方法、下标以及构造器，因此可以实现协议的定义。
 
 通过扩展令已有类型遵循并符合协议时，该类型的所有实例也会随之获得协议中定义的各项功能。
 
     protocol TextRepresentable {
         var textualDescription: String { get }
     }
 
     extension Dice: TextRepresentable {
         var textualDescription: String {
             return "A \(sides)-sided dice"
         }
     }
 
     let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
     print(d12.textualDescription)
     // 打印 “A 12-sided dice”
 
     extension SnakesAndLadders: TextRepresentable {
         var textualDescription: String {
             return "A game of Snakes and Ladders with \(finalSquare) squares"
         }
     }
     print(game.textualDescription)
     // 打印 “A game of Snakes and Ladders with 25 squares”
 */

//: ## 条件遵循
/*:
 泛型类型可能只在某些情况下满足一个协议的要求，比如当类型的泛型形式参数遵循对应协议时。你可以通过在扩展类型时列出限制让泛型类型有条件地遵循某协议。在实现纳协议的名字后面写泛型 where 分句：
 
     extension Array: TextRepresentable where Element: TextRepresentable {
         var textualDescription: String {
         let itemsAsText = self.map { $0.textualDescription }
             return "[" + itemsAsText.joined(separator: ", ") + "]"
         }
     }
     let myDice = [d6, d12]
     print(myDice.textualDescription)
     // 打印 "[A 6-sided dice, A 12-sided dice]"
 
 */

//: ## 在扩展里声明实现协议
/*:
 当一个类型已经符合了某个协议中的所有要求，却还没有声明实现该协议时，可以通过空扩展体的扩展遵循该协议：
 
     struct Hamster {
         var name: String
         var textualDescription: String {
             return "A hamster named \(name)"
         }
     }
     extension Hamster: TextRepresentable {}
 
     let simonTheHamster = Hamster(name: "Simon")
     let somethingTextRepresentable: TextRepresentable = simonTheHamster
     print(somethingTextRepresentable.textualDescription)
     // 打印 “A hamster named Simon”
 
 */

//: ## 协议的继承
/*:
 协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔：
 
     protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
         // 这里是协议的定义部分
     }
 
 示例：
 
     protocol PrettyTextRepresentable: TextRepresentable {
         var prettyTextualDescription: String { get }
     }
 
     extension SnakesAndLadders: PrettyTextRepresentable {
         var prettyTextualDescription: String {
             var output = textualDescription + ":\n"
             for index in 1...finalSquare {
                 switch board[index] {
                 case let ladder where ladder > 0:
                     output += "▲ "
                 case let snake where snake < 0:
                     output += "▼ "
                 default:
                     output += "○ "
                 }
             }
             return output
         }
     }
 
     print(game.prettyTextualDescription)
     // A game of Snakes and Ladders with 25 squares:
     // ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○
 
 */

//: ## 类专属协议
/*:
 通过添加 AnyObject 或 class(貌似在4.2废弃了) 关键字到协议的继承列表，就可以限制协议只能被类类型采纳（以及非结构体或者非枚举的类型）。
 
     protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
         // 这里是类专属协议的定义部分
     }
 
 - Note:
 声明为类专属协议的协议可以当做引用类型使用。
 */

//: ## 协议合成
/*:
 可以使用协议组合来复合多个协议为一种类型。协议组合行为就和定义的临时局部协议一样拥有构成中所有协议的定义。协议组合不定义任何新的协议类型。
 
 协议组合使用 SomeProtocol & AnotherProtocol 的形式。可以列举任意数量的协议，用和符号（&）分开。除了协议列表，协议组合也能包含类类型。
 
     protocol Named {
         var name: String { get }
     }
     protocol Aged {
         var age: Int { get }
     }
     struct Person: Named, Aged {
         var name: String
         var age: Int
     }
     func wishHappyBirthday(to celebrator: Named & Aged) {
         print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
     }
     let birthdayPerson = Person(name: "Malcolm", age: 21)
     wishHappyBirthday(to: birthdayPerson)
     // 打印 “Happy birthday Malcolm - you're 21!”
 
     class Location {
         var latitude: Double
         var longitude: Double
         init(latitude: Double, longitude: Double) {
             self.latitude = latitude
             self.longitude = longitude
         }
     }
     class City: Location, Named {
         var name: String
         init(name: String, latitude: Double, longitude: Double) {
             self.name = name
             super.init(latitude: latitude, longitude: longitude)
         }
     }
     func beginConcert(in location: Location & Named) {
         print("Hello, \(location.name)!")
     }
 
     let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
     beginConcert(in: seattle)
     // Prints "Hello, Seattle!"
 
 */

//: ## 检查协议类型
/*:
 可以使用类型转换中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并且可以转换到指定的协议类型。检查和转换到某个协议类型在语法上和类型的检查和转换完全相同：
 - is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false
 - as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil
 - as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误
 
 示例：
 
     protocol HasArea {
         var area: Double { get }
     }
 
     class Circle: HasArea {
         let pi = 3.1415927
         var radius: Double
         var area: Double { return pi * radius * radius }
         init(radius: Double) { self.radius = radius }
     }
     class Country: HasArea {
         var area: Double
         init(area: Double) { self.area = area }
     }

     class Animal {
         var legs: Int
         init(legs: Int) { self.legs = legs }
     }
 
     let objects: [AnyObject] = [
         Circle(radius: 2.0),
         Country(area: 243_610),
         Animal(legs: 4)
     ]
 
     for object in objects {
         if let objectWithArea = object as? HasArea {
             print("Area is \(objectWithArea.area)")
         } else {
             print("Something that doesn't have an area")
         }
     }
     // Area is 12.5663708
     // Area is 243610.0
     // Something that doesn't have an area
 
 */

//: ## 可选协议
/*:
 Swift 可以定义可选协议，遵循协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀来定义可选协议。可选协议用在需要和 Objective-C 打交道的代码中。协议名和可选协议定义都必须带上 @objc 属性。标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
 
 使用可选协议时，它们的类型会自动变成可选的。比如，一个类型为 (Int) -> String 的方法会变成 ((Int) -> String)?。需要注意的是整个函数类型是可选的，而不是函数的返回值。
 
 协议中的可选方法或属性可通过可选链调用，因为遵循协议的类型可能没有实现这些可选要求。类似 someOptionalMethod?(someArgument) 这样，可以在可选方法名称后加上 ? 来调用可选方法；
 
     @objc protocol CounterDataSource {
         @objc optional func incrementForCount(count: Int) -> Int
         @objc optional var fixedIncrement: Int { get }
     }
 
     class Counter {
         var count = 0
         var dataSource: CounterDataSource?
         func increment() {
             if let amount = dataSource?.incrementForCount?(count) {
                 count += amount
             } else if let amount = dataSource?.fixedIncrement {
                 count += amount
             }
         }
     }
 
 */

//: ## 协议扩展
/*:
 协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现。通过这种方式，可以基于协议本身来实现这些功能，而无需在每个遵循协议的类型中都重复同样的实现，也无需使用全局函数。
 
     extension RandomNumberGenerator {
         func randomBool() -> Bool {
             return random() > 0.5
         }
     }
 
     let generator = LinearCongruentialGenerator()
     print("Here's a random number: \(generator.random())")
     // 打印 “Here's a random number: 0.37464991998171”
     print("And here's a random Boolean: \(generator.randomBool())")
     // 打印 “And here's a random Boolean: true”
 
 */

//: ## 提供默认实现
/*:
 可以通过协议扩展来为协议要求的属性、方法以及下标提供默认的实现。如果遵循协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。
 
     extension PrettyTextRepresentable  {
         var prettyTextualDescription: String {
             return textualDescription
         }
     }
 */

//: ## 条件限制
/*:
 在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现。这些限制条件写在协议名之后，使用 where 子句来描述：
 
     extension Collection where Element: Equatable {
         func allEqual() -> Bool {
             for element in self {
                 if element != self.first {
                     return false
                 }
             }
             return true
         }
     }
 
     let equalNumbers = [100, 100, 100, 100, 100]
     let differentNumbers = [100, 100, 200, 100, 200]
 
     print(equalNumbers.allEqual())
     // 打印 "true"
     print(differentNumbers.allEqual())
     // 打印 "false"
 
 */
//: [下一页](@next)

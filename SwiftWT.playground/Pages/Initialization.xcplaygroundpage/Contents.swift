//
// Initialization.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 构造过程
/*:
 Swift 通过定义构造器来实现构造过程，就像用来创建特定类型新实例的特殊方法。与 Objective-C 中的构造器不同，Swift 的构造器无需返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始化。
 */

//: ## 存储属性的初始赋值
/*:
 类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
 
 可以在构造器中为存储型属性赋初值，也可以在定义属性时为其设置默认值。
 
 - Note:
 当为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察者。
 */

//: ## 构造器
/*:
 构造器在创建某个特定类型的新实例时被调用，以关键字 init 命名：
 
     init() {
         // 在此处执行构造过程
     }
 
     struct Fahrenheit {
         var temperature: Double
         init() {
             temperature = 32.0
         }
     }
     var f = Fahrenheit()
     print("The default temperature is \(f.temperature)° Fahrenheit")
     // 打印 "The default temperature is 32.0° Fahrenheit"
 
 */

//: ## 默认属性值
/*:
 可以在构造器中为存储型属性设置初始值，同样，也可以在属性声明时为其设置默认值：
 
     struct Fahrenheit {
         var temperature = 32.0
     }
 
 */

//: ## 构造参数
/*:
 自定义构造过程时，可以在定义中提供构造参数，指定参数值的类型和名字。构造参数的功能和语法跟函数和方法的参数相同：
 
     struct Celsius {
         var temperatureInCelsius: Double
         init(fromFahrenheit fahrenheit: Double) {
             temperatureInCelsius = (fahrenheit - 32.0) / 1.8
         }
         init(fromKelvin kelvin: Double) {
             temperatureInCelsius = kelvin - 273.15
         }
     }
 
     let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
     // boilingPointOfWater.temperatureInCelsius 是 100.0
     let freezingPointOfWater = Celsius(fromKelvin: 273.15)
     // freezingPointOfWater.temperatureInCelsius 是 0.0
 
 */

//: ## 参数名和参数标签
/*:
 跟函数和方法参数相同，构造参数也拥有一个在构造器内部使用的参数名和一个在调用构造器时使用的参数标签:
 
     struct Color {
         let red, green, blue: Double
         init(red: Double, green: Double, blue: Double) {
             self.red   = red
             self.green = green
             self.blue  = blue
         }
         init(white: Double) {
             red   = white
             green = white
             blue  = white
         }
     }
 
     let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
     let halfGray = Color(white: 0.5)
 
 如果不希望为构造器的某个参数提供参数标签，可以使用下划线（_）进行忽略：
 
     struct Celsius {
         var temperatureInCelsius: Double
         init(fromFahrenheit fahrenheit: Double) {
             temperatureInCelsius = (fahrenheit - 32.0) / 1.8
         }
         init(fromKelvin kelvin: Double) {
             temperatureInCelsius = kelvin - 273.15
         }
         init(_ celsius: Double){
             temperatureInCelsius = celsius
         }
     }
 
     let bodyTemperature = Celsius(37.0)
     // bodyTemperature.temperatureInCelsius 为 37.0
 
 */

//: ## 可选类型初始化
/*:
 可选类型的属性将自动初始化为 nil，表示这个属性是有意在初始化时设置为空的。
 
     class SurveyQuestion {
         var text: String
         var response: String?
         init(text: String) {
             self.text = text
         }
         func ask() {
             print(text)
         }
     }
 
     let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
     cheeseQuestion.ask()
     // 打印 "Do you like cheese?"
     cheeseQuestion.response = "Yes, I do like cheese."
 */

//: ## 常量属性初始化
/*:
 在构造过程中的任意时间点给常量属性指定一个值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可更改：
 
     class SurveyQuestion {
         let text: String
         var response: String?
         init(text: String) {
             self.text = text
         }
         func ask() {
             print(text)
         }
     }
 
     let beetsQuestion = SurveyQuestion(text: "How about beets?")
     beetsQuestion.ask()
     // 打印 "How about beets?"
     beetsQuestion.response = "I also like beets. (But not with cheese.)"
 
 - Note:
 类的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。
 */

//: ## 默认构造器
/*:
 如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器（default initializers）。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例：
 
     class ShoppingListItem {
         var name: String?
         var quantity = 1
         var purchased = false
     }
     var item = ShoppingListItem()
 
 */

//: ## 结构体的逐一成员构造器
/*:
 如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器（memberwise initializer），即使结构体的存储型属性没有默认值：
 
     struct Size {
         var width = 0.0, height = 0.0
     }
     let twoByTwo = Size(width: 2.0, height: 2.0)
 
 */

//: ## 值类型的构造器代理
/*:
 构造器可以通过调用其它构造器来完成实例的部分构造过程称为构造器代理，能避免多个构造器间的代码重复。
 
 构造器代理的实现规则和形式在值类型和类类型中不同。值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单，只能代理给自己的其它构造器。类可以继承自其它类，类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。
 
 如果为某个值类型定义了一个自定义的构造器，将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器），如果需要同时使用默认构造器和自定义构造器，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中。
 
     struct Size {
         var width = 0.0, height = 0.0
     }
 
     struct Point {
         var x = 0.0, y = 0.0
     }
 
 
     struct Rect {
         var origin = Point()
         var size = Size()
         init() {}
 
         init(origin: Point, size: Size) {
             self.origin = origin
             self.size = size
         }
 
         init(center: Point, size: Size) {
             let originX = center.x - (size.width / 2)
             let originY = center.y - (size.height / 2)
             self.init(origin: Point(x: originX, y: originY), size: size)
         }
     }
 
     let basicRect = Rect()
     // basicRect 的 origin 是 (0.0, 0.0)，size 是 (0.0, 0.0)
 
     let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
     size: Size(width: 5.0, height: 5.0))
     // originRect 的 origin 是 (2.0, 2.0)，size 是 (5.0, 5.0)
 
     let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
     size: Size(width: 3.0, height: 3.0))
     // centerRect 的 origin 是 (2.5, 2.5)，size 是 (3.0, 3.0)
 
 */

//: ## 类的继承和构造过程
/*:
 类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。 Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们分别是指定构造器和便利构造器。
 */
//: ### 指定构造器和便利构造器
/*:
 指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类合适的构造器来实现父类的初始化。
 
 类倾向于拥有少量指定构造器，普遍的是一个类拥有一个指定构造器。指定构造器在初始化的地方通过“管道”将初始化过程持续到父类链。
 
 每一个类都必须至少拥有一个指定构造器。
 
 便利构造器是类中比较次要的、辅助型的构造器。可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。
 
 ### 指定构造器和便利构造器的语法
 类的指定构造器的写法跟值类型简单构造器一样：
 
     init(parameters) {
         statements
     }
 
 便利构造器也采用相同样式的写法，但需要在 init 关键字之前放置 convenience 关键字，并使用空格将它们俩分开：
 
     convenience init(parameters) {
         statements
     }
 
 */
//: ## 类的构造器代理规则
/*:
 为了简化指定构造器和便利构造器之间的调用关系，Swift 采用以下三条规则来限制构造器之间的代理调用：
 1. 指定构造器必须调用其直接父类的的指定构造器
 2. 便利构造器必须调用同类中定义的其它构造器
 3. 便利构造器最后必须调用指定构造器
 
 简而言之：
 - 指定构造器必须总是向上代理
 - 便利构造器必须总是横向代理
 
 ![示例](initializerDelegation01_2x.png)
 */

//: ## 两段构造过程
/*:
 第一个阶段，类中的每个存储型属性赋一个初始值；当每个存储型属性的初始值被赋值后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步定制它们的存储型属性。
 
 两段式构造过程可以防止属性值在初始化之前被访问，也可以防止属性被另外一个构造器意外地赋予不同的值。
 - Note:
 Swift 的两段式构造过程跟 Objective-C 中的构造过程类似。最主要的区别在于阶段 1，Objective-C 给每一个属性赋值 0 或空值（比如说 0 或 nil）。Swift 的构造流程则更加灵活，它允许你设置定制的初始值，并自如应对某些属性不能以 0 或 nil 作为合法默认值的情况。
 
 ### 安全检查手段
 Swift 编译器将执行 4 种有效的安全检查，以确保两段式构造过程不出错地完成：
 - 指定构造器必须保证它所在类的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器
 - 指定构造器必须在为继承的属性设置新值之前向上代理调用父类构造器，否则，指定构造器赋予的新值将被父类中的构造器所覆盖
 - 便利构造器必须为任意属性（包括同类中定义的）赋新值之前代理调用同一类中的其它构造器，否则，便利构造器赋予的新值将被同一类中其它指定构造器所覆盖
 - 构造器在第一阶段构造完成之前，不能调用任何实例方法，不能读取任何实例属性的值，不能引用 self 作为一个值
 */

//: ## 构造器继承与Override
/*:
 Swift 中的子类默认情况下不会自动继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更精细的子类继承，并被错误地用来创建子类的实例。
 
 重写父类的指定构造器时，需要添加 override 修饰符。重写只存在于指定构造器中，编写与父类的同名便利构造器时，不存在重写，不需要添加 override 修复符。
 
 定义一个类：
 
     class Vehicle {
         var numberOfWheels = 0
         var description: String {
             return "\(numberOfWheels) wheel(s)"
         }
     }
 
     let vehicle = Vehicle()
     print("Vehicle: \(vehicle.description)")
     // Vehicle: 0 wheel(s)
 
 派生子类：
 
     class Bicycle: Vehicle {
         override init() {
             super.init()
             numberOfWheels = 2
         }
     }
 
     let bicycle = Bicycle()
     print("Bicycle: \(bicycle.description)")
     // 打印 "Bicycle: 2 wheel(s)"
 
 */
//: ### 构造器的自动继承
/*:
 子类在默认情况下不会继承父类的构造器。但是如果满足特定条件，父类构造器是可以被自动继承的：
 - 如果子类没有定义任何指定构造器，它将自动继承父类所有的指定构造器
 - 如果子类提供了所有父类指定构造器的实现——无论是通过上述规则继承过来的，还是提供了自定义实现——它将自动继承父类所有的便利构造器。除此之外，子类可以将父类的指定构造器实现为便利构造器
 */
//: ### 举个例子
/*:
 定义一个类：
 
     class Food {
         var name: String
         init(name: String) {
             self.name = name
         }
 
         convenience init() {
             self.init(name: "[Unnamed]")
         }
     }
 
     let namedMeat = Food(name: "Bacon")
     // namedMeat 的名字是 "Bacon"
 
     let mysteryMeat = Food()
     // mysteryMeat 的名字是 [Unnamed]
 
 定义一个子类，将父类指定构造器重写为便利构造器：
 
     class RecipeIngredient: Food {
         var quantity: Int
         init(name: String, quantity: Int) {
         self.quantity = quantity
             super.init(name: name)
         }
         override convenience init(name: String) {
             self.init(name: name, quantity: 1)
         }
     }
 
     let oneMysteryItem = RecipeIngredient()
     let oneBacon = RecipeIngredient(name: "Bacon")
     let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
 
 定义一个子类，使用自动继承构造器：
 
     class ShoppingListItem: RecipeIngredient {
         var purchased = false
         var description: String {
         var output = "\(quantity) x \(name)"
             output += purchased ? " ✔" : " ✘"
             return output
         }
     }
 
     var breakfastList = [
         ShoppingListItem(),
         ShoppingListItem(name: "Bacon"),
         ShoppingListItem(name: "Eggs", quantity: 6),
     ]
     breakfastList[0].name = "Orange juice"
     breakfastList[0].purchased = true
     for item in breakfastList {
         print(item.description)
     }
     // 1 x orange juice ✔
     // 1 x bacon ✘
     // 6 x eggs ✘
 */

//: ## 可失败构造器
/*:
 如果一个类、结构体或枚举类型的对象，在构造过程中有可能失败，可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在 init 关键字后面添加问号（init?），也可以通过在 init 后面添加惊叹号的方式来定义一个可失败构造器（init!），这样返回的将是一个隐式解析可选的实例。可失败构造器不能与其他构造器同名。
 
 可失败构造器会创建一个类型为自身类型的可选类型的对象。通过 return nil 语句来表明可失败构造器在何种情况下应该 “失败”。
 
     let wholeNumber: Double = 12345.0
     let pi = 3.14159
 
     if let valueMaintained = Int(exactly: wholeNumber) {
         print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
     }
     // 打印 "12345.0 conversion to Int maintains value of 12345"
 
     let valueChanged = Int(exactly: pi)
     // valueChanged 是 Int? 类型，不是 Int 类型
 
     if valueChanged == nil {
         print("\(pi) conversion to Int does not maintain value")
     }
     // 打印 "3.14159 conversion to Int does not maintain value"
 
 定义一个结构体：
 
     struct Animal {
         let species: String
         init?(species: String) {
             if species.isEmpty {
                 return nil
             }
             self.species = species
         }
     }
 
     let someCreature = Animal(species: "Giraffe")
     // someCreature 的类型是 Animal? 而不是 Animal
 
     if let giraffe = someCreature {
         print("An animal was initialized with a species of \(giraffe.species)")
     }
     // 打印 "An animal was initialized with a species of Giraffe"
 
     let anonymousCreature = Animal(species: "")
     // anonymousCreature 的类型是 Animal?, 而不是 Animal
 
     if anonymousCreature == nil {
         print("The anonymous creature could not be initialized")
     }
     // 打印 "The anonymous creature could not be initialized"
 
 */

//: ## 枚举类型的可失败构造器
/*:
 可以通过一个带一个或多个参数的可失败构造器来获取枚举类型中特定的枚举成员。如果提供的参数无法匹配任何枚举成员，则构造失败。
 
     enum TemperatureUnit {
         case Kelvin, Celsius, Fahrenheit
         init?(symbol: Character) {
             switch symbol {
             case "K":
                 self = .Kelvin
             case "C":
                 self = .Celsius
             case "F":
                 self = .Fahrenheit
             default:
                 return nil
             }
         }
     }
 
     let fahrenheitUnit = TemperatureUnit(symbol: "F")
     if fahrenheitUnit != nil {
         print("This is a defined temperature unit, so initialization succeeded.")
     }
     // 打印 "This is a defined temperature unit, so initialization succeeded."
 
     let unknownUnit = TemperatureUnit(symbol: "X")
     if unknownUnit == nil {
         print("This is not a defined temperature unit, so initialization failed.")
     }
     // 打印 "This is not a defined temperature unit, so initialization failed."
 
 ### 带原始值
 带原始值的枚举类型会自带一个可失败构造器 init?(rawValue:)，该可失败构造器有一个名为 rawValue 的参数，其类型和枚举类型的原始值类型一致，如果该参数的值能够和某个枚举成员的原始值匹配，则该构造器会构造相应的枚举成员，否则构造失败：
 
     enum TemperatureUnit: Character {
         case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
     }
 
     let fahrenheitUnit = TemperatureUnit(rawValue: "F")
     if fahrenheitUnit != nil {
         print("This is a defined temperature unit, so initialization succeeded.")
     }
     // 打印 "This is a defined temperature unit, so initialization succeeded."
 
     let unknownUnit = TemperatureUnit(rawValue: "X")
     if unknownUnit == nil {
         print("This is not a defined temperature unit, so initialization failed.")
     }
     // 打印 "This is not a defined temperature unit, so initialization failed."
 
 */

//: ## 构造失败的传递
/*:
 类、结构体、枚举的可失败构造器可以横向代理到同类型中的其他可失败构造器。类似的，子类的可失败构造器也能向上代理到父类的可失败构造器。
 
 无论是向上代理还是横向代理，如果代理到的其他可失败构造器触发构造失败，整个构造过程将立即终止，接下来的任何构造代码不会再被执行。
 
 可失败构造器也可以代理到其它的非可失败构造器。通过这种方式可以增加一个可能的失败状态到现有的构造过程中。
 
     class Product {
         let name: String
         init?(name: String) {
             if name.isEmpty { return nil }
             self.name = name
         }
     }
 
     class CartItem: Product {
         let quantity: Int
         init?(name: String, quantity: Int) {
             if quantity < 1 { return nil }
             self.quantity = quantity
             super.init(name: name)
         }
     }
 
     if let twoSocks = CartItem(name: "sock", quantity: 2) {
         print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
     }
     // 打印 "Item: sock, quantity: 2"
 
     if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
         print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
     } else {
         print("Unable to initialize zero shirts")
     }
     // 打印 "Unable to initialize zero shirts"
 
     if let oneUnnamed = CartItem(name: "", quantity: 1) {
         print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
     } else {
         print("Unable to initialize one unnamed product")
     }
     // 打印 "Unable to initialize one unnamed product"
 */

//: ## Override 可失败构造器
/*:
 父类的可失败构造器可以被子类重写为可失败的构造器或者普通构造器，但是不可以将非可失败构造器重写为可失败构造器.
 
     class Document {
         var name: String?
         // 该构造器创建了一个 name 属性的值为 nil 的 document 实例
         init() {}
         // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
         init?(name: String) {
             self.name = name
             if name.isEmpty { return nil }
         }
     }
 
     class AutomaticallyNamedDocument: Document {
         override init() {
             super.init()
             self.name = "[Untitled]"
         }
         override init(name: String) {
             super.init()
             if name.isEmpty {
                 self.name = "[Untitled]"
             } else {
                 self.name = name
             }
         }
     }
 
     class UntitledDocument: Document {
         override init() {
             super.init(name: "[Untitled]")!
         }
     }
 
 */

//: ## 必要构造器
/*:
 在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器：
 
     class SomeClass {
         required init() {
             // 构造器的实现代码
         }
     }
 
 在子类重写父类的必要构造器时，必须在子类的构造器前也添加 required 修饰符，表明该构造器要求也应用于继承链后面的子类。在重写父类中必要的指定构造器时，不需要添加 override 修饰符：
 
     class SomeSubclass: SomeClass {
         required init() {
             // 构造器的实现代码
         }
     }
 
 */
//: [下一页](@next)

//
// Structures-and-Classes.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 类与结构体
/*:
 Swift 可以使用完全相同的语法规则来为类和结构体定义属性（常量、变量）和添加方法，扩展类和结构体的功能。
 
 与其他编程语言所不同的是，Swift 并不要求你为自定义类和结构去创建独立的接口和实现文件。你所要做的是在一个单一文件中定义一个类或者结构体，系统将会自动生成面向其它代码的外部接口。
 */

//: ## 类和结构体对比
/*:
 相同点：
 - 定义属性用于存储值
 - 定义方法用于提供功能
 - 定义下标操作通过下标语法可以访问它们的值
 - 定义构造器用于生成初始化值
 - 通过扩展以增加默认实现的功能
 - 遵循协议以提供某种标准功能
 
 与结构体相比，类还有如下的附加功能：
 - 继承允许一个类继承另一个类
 - 类型转换允许在运行时检查和解释一个类实例的类型
 - 析构器允许一个类实例释放任何其所被分配的资源
 - 引用计数允许对一个类的多次引用
 
 - Note:
 结构体总是通过被复制的方式在代码中传递，不使用引用计数。
 */

//: ## 定义语法
/*:
 类和结构体有着类似的定义方式。我们通过关键字 class 和 struct 来分别表示类和结构体，并在一对大括号中定义它们的具体内容：
 
     class SomeClass {
         // 在这里定义类
     }
     struct SomeStructure {
         // 在这里定义结构体
     }
 
 定义一个类和结构体：
 
     struct Resolution {
         var width = 0
         var height = 0
     }
     class VideoMode {
         var resolution = Resolution()
         var interlaced = false
         var frameRate = 0.0
         var name: String?
     }
 
 */

//: ## 类和结构体实例
/*:
 生成结构体和类实例的语法非常相似，结构体和类都使用构造器语法来生成新的实例；构造器语法的最简单形式是在结构体或者类的类型名称后跟随一对空括号，如 Resolution() 或 VideoMode()：
 
     let someResolution = Resolution()
     let someVideoMode = VideoMode()
 
 */

//: ## 属性访问
/*:
 通过使用点语法，可以访问实例的属性；语法规则是，实例名后面紧跟属性名，两者通过点号（.）连接：
 
     print("The width of someResolution is \(someResolution.width)")
     // 打印 "The width of someResolution is 0"
 
     print("The width of someVideoMode is \(someVideoMode.resolution.width)")
     // 打印 "The width of someVideoMode is 0"
 
     someVideoMode.resolution.width = 1280
     print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
     // 打印 "The width of someVideoMode is now 1280"
 
 */

//: ## 结构体类型的成员逐一构造器
/*:
 所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性：
 
     let vga = Resolution(width: 640, height: 480)
 
 类与结构体不同，类没有默认的成员逐一构造器。
 */

//: ## 结构体和枚举是值类型
/*:
 值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。在 Swift 中，所有的结构体和枚举类型都是值类型。
 
     let hd = Resolution(width: 1920, height: 1080)
     var cinema = hd
 
     cinema.width = 2048
 
     print("cinema is now  \(cinema.width) pixels wide")
     // 打印 "cinema is now 2048 pixels wide"
 
     print("hd is still \(hd.width) pixels wide")
     // 打印 "hd is still 1920 pixels wide"
 
     enum CompassPoint {
         case North, South, East, West
     }
     var currentDirection = CompassPoint.West
     let rememberedDirection = currentDirection
     currentDirection = .East
     if rememberedDirection == .West {
         print("The remembered direction is still .West")
     }
     // 打印 "The remembered direction is still .West"
 */
//: ## 类是引用类型
/*:
 与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已存在的实例本身而不是其拷贝。
 
     let tenEighty = VideoMode()
     tenEighty.resolution = hd
     tenEighty.interlaced = true
     tenEighty.name = "1080i"
     tenEighty.frameRate = 25.0
 
     let alsoTenEighty = tenEighty
     alsoTenEighty.frameRate = 30.0
 
     rint("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
     // 打印 "The frameRate property of theEighty is now 30.0"
 
 */

//: ### 恒等运算符
/*:
 Swift 内建了两个恒等运算符：
 - 等价于（===）
 - 不等价于（!==）
 
 运用这两个运算符检测两个常量或者变量是否引用同一个实例：
 
     if tenEighty === alsoTenEighty {
         print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
     }
     //打印 "tenEighty and alsoTenEighty refer to the same Resolution instance."
 
 “等价于”（用三个等号表示，===）与“等于”（用两个等号表示，==）的不同：
 - “等价于”表示两个类类型（class type）的常量或者变量引用同一个类实例。
 - “等于”表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相等”来说，这是一种更加合适的叫法。
 
 */

//: ## 指针
/*:
 一个引用某个引用类型实例的 Swift 常量或者变量，与 C 语言中的指针类似，但是并不直接指向某个内存地址，也不要求使用星号（*）来表明你在创建一个引用。Swift 中的这些引用与其它的常量或变量的定义方式相同。
 */

//: ## 字符串、数组、和字典类型的赋值与复制行为
/*:
 Swift 中，许多基本类型，诸如 String，Array 和 Dictionary 类型均以结构体的形式实现。这意味着被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。
 
 Objective-C 中 NSString，NSArray 和 NSDictionary 类型均以类的形式实现，而并非结构体。它们在被赋值或者被传入函数或方法时，不会发生值拷贝，而是传递现有实例的引用。
 
 - Note:
 以上是对字符串、数组、字典的“拷贝”行为的描述。在代码中，Swift 在实现上只在绝对必要时才执行实际的拷贝。Swift 管理所有的值拷贝以确保性能最优化，所以你没必要去回避赋值来保证性能最优化。
 */
//: [下一页](@next)

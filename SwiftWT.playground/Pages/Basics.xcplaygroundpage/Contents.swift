//
// Basics.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # Swift基础部分
/*:
 `Swift`和其他语言一样，也有自己的内建类型，如整型`Int`，浮点型`Float`、`Double`，布尔`Bool`，字符(串)`Charactor`、`String`以及集合类型如：`Set`、`Array`、`Dictionary`等.
 
 `Swift`和其他大部分语言一样，也是通过变量存储可变值，使用常量存储不可变值，`Swift`中的常量比`C`语言家族的要强大和简单得多，在`Swift`中，常量就是常量，常量就是不可变的值，可以是一个引用，也可以是一个结构体值类型；常量的使用贯穿了整个`Swift`语言，这有点函数式编程的味道，使用常量可以使我们的代码变得更加简单和安全.
 
 `Optional`可选类型，可以说是`Swift`的心脏，`Swift`中的很多特性甚至标准库的构建都是基于可选的，`Swift`中的可选类型类似于`OC`中的`nil`，但是远远比`OC`的`nil`要强大.
 */

//: ## 常量与变量
/*:
 ### 常量与变量的声明
 `Swift`中常量和变量的声明很简单，`var`声明变量，`let`生命常量，而且大多数时候不需要指定类型，`Swift`强大的类型推断可以推测常量/变量的类型
 
     var variable = 1
     let constant = 1
 
     print(variable) // 1
 
 同时声明多个常量/变量
 
     var a = 0.0, b = 0.0, c = 0.0
     let x = 0.0, y = 0.0, z = 0.0
 
     print(a) // 0.0
 */
var a = 0.0, b = 0.0, c = 0.0
let x = 0.0, y = 0.0, z = 0.0
//: ## 类型声明
/*:
 类型声明在`Swift`是可选的，因为`Swift`有类型推断的机制；但是在一些复杂场景下，如声明可选类型或引用复杂表达式的情况，类型声明就显得很有必要；类型声明很简单，只需要在常量/变量名后边加上冒号和类型名即可：
 
     let variable: VariableType = value
     var optional: OptionalType?
     let value: String? = regex.matches(in: contents, option: []).first?.map { $0 }
 
 同时声明多个**相同类型**的常量/变量：
 
     var red, green, blue: Int
     let redc, greenc, bluec: Int
 
     red = 1
     redc = 1
     redc = 2 // Error: Change 'let' to 'var' to make it mutable.
 
     print(green) // Error: Variable 'green' used before initialized.
 
 - Note:
 `Swift`在安全性里做过概述，所有常量/变量必须要初始化之后才能使用.
 */

//: ## 变量命名
/*:
 `Swift`变量命名可以使用几乎所有的字符，包括`Unicode`：
 
     let π = 3.14159
     let 你好 = "你好世界"
     let 🐶🐮 = "dogcow"
 
 命名规则：
 - 不能包含空格、数学符号、保留的`Unicode`字符、连线符与制表符
 - 不能以数字开头，不能使用保留字符
 - 若要使用保留字符，遵循格式：\`for\`
 */

//: ## 打印
/*:
 `Swift`中打印常量/变量的值使用`print`函数：
 
     let variable = 1
     print(variable) // 1
 
 格式化输出：`print("%d%.2f%s", intValue, floatValue, stringValue)`：
 
     let intValue = 1
     let floatValue = 1.0
     let stringValue = "string"
     print(String(format: "%d-%.2f-%@", intValue, floatValue, stringValue)) // 1-1.00-string
 
 `print`函数：`func print(_ items: Any..., separator: String = default, terminator: String = default)`，可以支持自定义的打印：
 
     let intValue = 1
     let floatValue = 1.0
     let stringValue = "string"
     print(intValue, floatValue, stringValue) // separator默认为" "
     // 1 1.0 string
     print(a, b, c, separator: "\n")
     // 1
     // 1.0
     // string
 
 `Swift`还支持‘字符串插值’，当我们在字符串中插入`\(value)`时，`value`的值就会被插入字符串中：
 
     print("The current value of friendlyWelcome is \(friendlyWelcome)")
     // Prints "The current value of friendlyWelcome is Bonjour!"
 */

//: ## 注释
/*:
 `Swift`注释跟其他语言一样，使用`//`进行注释，文档化单行注释需要使用`///`，多行注释使用`\/\*\*\/`的语法，另外，`Swift`的文档化注释支持`Markdown`的语法，对于文档注释的编写很方便也很友好：
 
     /// Another description
     ///
     /// - important: Make sure you read this
     /// - returns: a Llama spotter rating between 0 and 1 as a Float
     /// - parameter totalLlamas: The number of Llamas spotted on the trip
     ///
     /// More description

 `Swift`多行注释可以嵌套，使用嵌套注释可以将注释的内容模块化，方便文档化及查阅：
 
     \/\* This is the start of the first multiline comment.
     \/\* This is the second, nested multiline comment. \*\/
     This is the end of the first multiline comment. \*\/
 
 [Markup Formatting Reference](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref)
 */

//: ## 语句结束标识 '**`;`**'
/*:
 在`C`语言家族中，没一条语句结束都必须添加语句结束标识符`;`，但是在`Swift`中是可选的，`Swift`中的语句结束标识是换行符，也就是说，编写`Swift`代码的时候可以不用编写`;`；但是当一行有一个以上的语句时，就需要添加`;`用以分割：
 
     let cat = "🐱"; print(cat)
     // Prints "🐱"
 
 */

//: ## 整型
/*:
 `Swift`整型类型是`Int`，代表整型数值，`Swift`提供了各种长度的整型类型：
 - `Int8`, `UInt8`：8位
 - `Int16`, `UInt16`：16位
 - `Int32`, `UInt32`：32位
 - `Int64`, `UInt64`：64位
 默认`Int`是平台相关的，在32位机器上`Int`长度是32位，在64位机器上`Int`是64位.
 
 ### 获取`Int`范围
 `Swift`中获取`Int`范围可以通过内建属性`min`, `max`来获取：
 
     let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
     let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8
 */

//: ## 浮点型
/*:
 `Swift`中浮点型是`Float`和`Double`，`Float`精度是6，`Double`的精度是15. `Float`的长度是32位，`Double`的长度64位.
 */

//: ## 类型安全与类型推断
/*:
 `Swift`是类型安全的语言，对类型特别敏感，一个`String`类型的变量不会接受非`String`类型的值，`Swift`编译器会在编译期间进行类型检查，并将不匹配的类型标记为错误；`Swift`的类型推断特性可以在不声明变量类型的时候通过变量值推断出变量的类型，这在简单的场景下非常实用，减少了一定的代码量，但是在复杂情况下还是最好声明变量的类型，这样有利于代码的可读性：
 
     let meaningOfLife = 42
     // meaningOfLife is inferred to be of type Int
     let pi = 3.14159
     // pi is inferred to be of type Double
     let anotherPi = 3 + 0.14159
     // anotherPi is also inferred to be of type Double
 
 需要注意的是，`Swift`在进行类型推断的时候为了做兼容性处理，永远会把浮点型字面量推断为`Double`类型.
 */

//: ## 数值字面量
/*:
 数值字面量可以使用10进制、2进制、8进制、16进制进行编写：
 - 10进制：数值无前缀
 - 2进制：`0b`+数值
 - 8进制：`0o`+数值
 - 16进制：`0x`+数值
 
 浮点型数值字面量也可以使用10进制和16进制，在小数点两边都必须要有至少一个数值(不像OC可以写作.3f)；10进制的浮点数可以有一个可选的指数`e`来标记分位，16进制则必须有一个指数来标记分位，使用`P`或`p`来标记：
 10进制标记指数：
 
     1.25e2 means 1.25 x 102, or 125.0.
     1.25e-2 means 1.25 x 10-2, or 0.0125.
 
 16进制标记指数：
 
     0xFp2 means 15 x 22, or 60.0.
     0xFp-2 means 15 x 2-2, or 3.75.
 
 以下都表示浮点数`12.1875`：
 
     let decimalDouble = 12.1875
     let exponentDouble = 1.21875e1
     let hexadecimalDouble = 0xC.3p0
 
 数值字面量可以通过额外的格式化增加可读性，可以通过额外的`0`或下划线`_`来格式化字面量：
 
     let paddedDouble = 000123.456 // 在前面添加`0`
     let oneMillion = 1_000_000 // 下划线分隔
     let justOverOneMillion = 1_000_000.000_000_1

 */

//: ## 数值类型转换
/*:
 一般情况下，在`Swift`使用整型的时候尽量使用`Int`，默认的`Int`编译器做了优化，可以直接被复用，而且更加利于类型推断系统的运作；只有在明确需要用到其他整型类型的时候，才需要制定其他类型，如明确数值长度、性能优化等. `Swift`中默认的不同的数值类型不能直接做加减乘除运算，除非重载运算符以实现. 数值字面量的类型是不定的，只有在编译器做类型推导的时机才会确定数值字面量的类型：
 
     let pi = 3 + 0.141592654 // 因为0.141592654是Double类型，因此3会被推断为Double而不是Int
 
     let three = 3
     let pointOneFourOneFiveNine = 0.14159
     let pi = three + pointOneFourOneFiveNine // Error: note: overloads for '+' exist with these partially matching parameter lists: (Double, Double), (Int, Int), (Date, TimeInterval), (DispatchTime, Double), (DispatchWallTime, Double), (Int, UnsafeMutablePointer<Pointee>), (Int, UnsafePointer<Pointee>)
 
 ### 整型转换
 在`Swift`中类型是敏感的，`Int8`类型的值是不能直接赋值给`Int32`的，因为这在`Swift`中是两个完全不同的类型，如果需要将`Int8`的值赋值给`Int32`的变量，则需要显式的进行类型转换：
 
     let int8: Int8 = 127
     let int32: Int32 = int8 // Error: cannot convert value of type 'Int8' to specified type 'Int32'
     let int32: Int32 = Int32(int8)
 
 数值类型的转换就是通过调用对应数值的初始化方法，将需要转换的数值作为参数传递即可.
 - Note:
     将长度高的数据转换为长度第的数值可能会失败，造成运行时错误：
 
         let int32: Int32 = 1000000
         let int8: Int8 = Int8(int32) // Fatal error: Not enough bits to represent a signed value
 
 ### 整型与浮点型转换
 整型和浮点数进行转换也是同样的方式，调用需要转换类型的初始化方法，将需要转换的变量作为参数传入即可：
 
     let three = 3
     let pointOneFourOneFiveNine = 0.14159
     let pi = Double(three) + pointOneFourOneFiveNine
     // pi equals 3.14159, and is inferred to be of type Double
 */
let aa = 2
let bb = 2.0
let ddd = Double(aa) + bb
//: ## 类型别名
/*:
 类似`C`语言家族，`Swift`也有类型别名的语法，通过指定别名可以使别名拥有和被指定别名的类型一样的功效：
 
     typealias AudioSample = UInt16
 
     var maxAmplitudeFound = AudioSample.min
     // maxAmplitudeFound is now 0
 
 别名声明之后，可以在别名作用域内的任何地方使用.
 */

//: ## 布尔类型
/*:
 `Swift`中的布尔值不同于其他语言的布尔值，大部分其他语言中的布尔其实也是一个整型值，通过`0`与`!0`来表示真与假，`Swift`中的布尔值只有两个值：`true`、`false`，而且不能与其他类型转换. 需要注意的是，在`Swift`中使用流程控制语法，条件体中只能是布尔类型的值，不接受其他类型的值：
 
     let i = 1
     if i {
         // this example will not compile, and will report an error
     }
 
     let i = 1
     if i == 1 {
         // this example will compile successfully
     }
 
 */

//: ## 元组类型
/*:
 元组可以将多个其他类型的值联合在一起作为一个新的类型的值，这个新的类型就是元组，因此元组是复合类型，元组的类型是由组成元组的类型决定的，组成元组类型的类型可以是任何类型和任意多的类型：
 
     let http404Error = (404, "Not Found")
     // http404Error is of type (Int, String), and equals (404, "Not Found")
 
 元组可以作为`Swift`中的类型来使用，和使用其他类型一样，但是元组只适合数据较少的场景，对于数据较大的场景，不推荐使用.
 */

/*:
 ### 元组类型的定义
 定义一个元组类型很简单，使用括号将联合的类型声明在一起即可：
 
     typealias Tuple = (Int, Float, Double, String) // 无标签
     typealias Tuple = (int: Int, float: Float, double: Double, string: String) // 标签
*/

/*:
 ### 元组的分解
 - 元组是由若干个其他类型的值联合而成的值，因此元组的分解也很简单，使用变量或常量声明的语法将值**一一对应**起来即可：
 
         let (statusCode, statusMessage) = http404Error
         print("The status code is \(statusCode)")
         // Prints "The status code is 404"
         print("The status message is \(statusMessage)")
         // Prints "The status message is Not Found"
 
 - 可以使用下划线 `_` **忽略匹配**：
 
         let (justTheStatusCode, _) = http404Error
         print("The status code is \(justTheStatusCode)")
         // Prints "The status code is 404"

 - 可以使用**下标位置**取值：
 
         print("The status code is \(http404Error.0)")
         // Prints "The status code is 404"
         print("The status message is \(http404Error.1)")
         // Prints "The status message is Not Found"
 
 - 可以使用**标签**：
 
         let http200Status = (statusCode: 200, description: "OK")
         print("The status code is \(http200Status.statusCode)")
         // Prints "The status code is 200"
         print("The status message is \(http200Status.description)")
         // Prints "The status message is OK"
 */

//: ## 可选类型
/*:
 在`Swift`中，所有类型的变量或实例都只接受对应类型的值，还有一种情况就是值为**空**`(nil)`的情况，这个时候，就需要将类型声明为`Optional<T>`的类型. `Optional`类型的变量/常量可以接受对应Wrapped的类型的值和`nil`，`nil`表示无值、空缺，`Optional`类型可以表示任何类型；在`C`和`OC`中也有`nil`和`NULL`的概念，表示空指针，这个和`Swift`中的`Optional`是不同的概念；`Optional`类型是`Swift`语言的心脏，`Swift`的很多特性和标准库都是基于`Optional`类型构建起来的.
 
 `Swift`可选类型的实现很简单，`Optional`其实就是一个泛型枚举，枚举的定义如下：
 
     public enum Optional<Wrapped>: ExpressibleByNilLiteral {
         case nil
         case some(Wrapped)
     }
 
 可选类型的声明两种方式：
 - 使用标准类型声明：
 
         var variable: Optional<Int>
 
 - 使用语法糖进行声明：
 
         var variable: Int?
 
 */

/*:
 ### `nil`
 通过给可选类型设值`nil`以表示值缺失：
 
     var serverResponseCode: Int? = 404
     // serverResponseCode contains an actual Int value of 404
     serverResponseCode = nil
     // serverResponseCode now contains no value
 
 当声明一个可选类型的变量时，这个变量的默认值为`nil`：
 
     var surveyAnswer: String?
     // surveyAnswer is automatically set to nil
 
 */

/*:
 ## 条件判断与强制解包
 声明为可选类型的变量不能直接使用，需要解包之后才能使用；可选类型变量可以通过判断是否为`nil`来进行强制解包，不过请注意，如果可选类型变量为`nil`，强制解包会触发运行时错误，因此在使用可选类型的时候，尤其是在强制解包的时候，一定要确保可选类型值不为`nil`；强制解包的语法很简单，只需要在变量名后边加上`!`即可：
 
     if convertedNumber != nil {
         print("convertedNumber has an integer value of \(convertedNumber!).")
     }
     // Prints "convertedNumber has an integer value of 123."
 */

/*:
 ## 可选绑定
 我们在处理可选类型的时候，需要明确确定有值才能解包，除了强制解包之外，可选类型还可以使用**可选绑定**的语法进行解包，这是一种安全的做法，可选绑定通过自动匹配可选类型变量的值，当值不为空是才解包；可选绑定的模式在`Swift`中很常见，语法：
 
     if let constantName = someOptional {
         statements
     }
 
 除了在`if`条件判断中使用，还可以在`while`、`guard`等流程控制中使用；一个流程控制域中可以同时进行多个可选绑定，只需要使用逗号 `,` 分隔开即可：
 
     if let actualNumber = Int(possibleNumber) {
         print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
     } else {
         print("\"\(possibleNumber)\" could not be converted to an integer")
     }
     // Prints ""123" has an integer value of 123"
 
     if let actualNumber = Int(possibleNumber), let secondActualNumber = actualNumber.someOptionalNumber {
          // statements
     }
 
     while let next = iterator.next() {
         // statements
     }
 
 可选绑定除了可以使用常量绑定之外，还可以使用变量绑定：
 
     if var actualNumber = somePossibleNumner {
         actualNumber = anotherPossibleNumber
     }
 
 */
let op: Int? = 1
let val = 1

if let _ = op {
    
}

if op != nil {
    
}

if let cval = val {
    
}
//: ## 隐式解析的可选类型
/*:
 隐式解析的可选类型是一种特殊的可选类型，隐式解析可选的类型的变量在使用的时候不用显式的解包，当在使用隐式解析可选类型的变量的时候，隐式解析可选类型会自动帮我们解包：
 
     let possibleString: String? = "An optional string."
     let forcedString: String = possibleString! // requires an exclamation mark
 
     let assumedString: String! = "An implicitly unwrapped optional string."
     let implicitString: String = assumedString // no need for an exclamation mark
 
 隐式解析可选可以用在当我们确定变量在初始化之后或者经过一系列处理之后不可能为空的情况下使用，这种时候隐式解析可选就完全可以当做普通类型来使用；相反，如果隐式解析可选变量是`nil`，我们在使用的时候就会触发运行时错误，这是我们需要注意的地方.
 
 隐式解析可选类型和可选类型类似，也是一个泛型枚举类型，叫做`ImplicitlyUnwrappedOptional<Wrapped>`，定义和`Optional`一样，所以在声明的时候就可以使用`var assumedString: ImplicitlyUnwrappedOptional<String>`的语法进行声明，同时，也可以使用语法糖简写：`var assumedString: String!`
 
 另外，隐式解析可选类型兼容可选类型，可以当做可选类型使用.
 */

//: ## 错误处理
/*:
 `Swift`中的错误处理简单而强大，通过协议`Error`定义错误类型，自定义错误类型只需要实现`Error`即可；`Swift`通过一系列的语法特性，使构建错误处理流程边的异常简单，在`Swift`中，如果一个函数在执行期间会产生错误信息，那么这个函数必须要声明成为"可错误"函数，通过管检测`throws`声明：`func functionCanThrow() throws -> Void`，通过这个标记，使函数在调用方看起来简明易懂，在实现函数的时候，只需要在必要的地方使用语法`throw Error`抛出错误信息即可.
 
 被标记为`throws`的函数在调用时，必须处理错误信息，`Swift`中的错误处理语法：
 
     do {
         try ...
     } catch {
         ...
     }
 
 错误信息会被抛出到`catch`块进行处理.
 
 在进行错误处理的时候，可以使用模式匹配的语法，如：
 
     func makeASandwich() throws {
     // ...
     }
 
     do {
         try makeASandwich()
         eatASandwich()
     } catch SandwichError.outOfCleanDishes {
         washDishes()
     } catch SandwichError.missingIngredients(let ingredients) {
         buyGroceries(ingredients)
     }
 
 将需要匹配的错误类型以及额外信息放置在`catch`语句后即可.
 */
let array = [1, 3, 4]
array[3]
//: ## 断言和前置条件
/*:
 断言和前置条件可以帮助我们调试程序，不满足断言或者前置条件的代码将会触发运行时错误，和错误处理不一样，断言和前置条件不能被捕获；断言只在`Debug`环境下生效，前置条件在`Debug`和`Release`都能生效，因此，在开发过程中可以使用任意数量的断言，但是前置条件就需要慎重使用.
 
 ### 断言使用
 断言函数是`Swift`标准库提供的全局函数：`assert(_:_:file:line:)`，第一个参数和第二个参数分别是断言条件和调试信息(可选)，当条件为真时程序才继续往下执行：
 
     let age = -3
     assert(age >= 0, "A person's age can't be less than zero.")
     // This assertion fails because -3 is not >= 0.
 
 ### 先决条件
 先决条件和断言一样，也是`Swift`标准库提供的全局函数：`precondition(_:_:file:line:)`，使用上没什么区别.
 
     // In the implementation of a subscript...
     precondition(index > 0, "Index must be greater than zero.")
 
 需要注意的地方：
 - `precondition`将会被`-Ounchecked`模式禁用，`-Ounchecked`模式下所有的`precondition`都将判真.
 - 需要忽略`-Ounchecked`的影响，可以使用`fatalError(_:file:line:)`函数.
 */
//: [下一页](@next)

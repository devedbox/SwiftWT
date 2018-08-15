//
// Strings-and-Characters.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation

//: # 字符与字符串
/*:
 字符串是是一系列字符的集合，例如 "hello, world"，"albatross"。Swift 的字符串通过 `String` 类型来表示。 一个 `String` 的内容可以用许多方式读取，包括作为一个 `Character` 值的集合。
 
 `Swift` 的 `String` 和 `Character` 类型提供了快速和兼容 `Unicode` 的方式供你的代码使用。创建和操作字符串的语法与 C 语言中字符串操作相似，轻量并且易读。字符串连接操作只需要简单地通过 + 符号将两个字符串相连即可。与 Swift 中其他值一样，能否更改字符串的值，取决于其被定义为常量还是变量。你也可以在字符串内插过程中使用字符串插入常量、变量、字面量表达成更长的字符串，这样可以很容易的创建自定义的字符串值，进行展示、存储以及打印。
 
 尽管语法简易，但 String 类型是一种快速、现代化的字符串实现。 每一个字符串都是由编码无关的 Unicode 字符组成，并支持访问字符的多种 Unicode 表示形式。
 
 - Note:
 Swift 的 String 类型与 Foundation NSString 类进行了无缝桥接。Foundation 也可以对 String 进行扩展，暴露在 NSString 中定义的方法。 这意味着，如果你在 String 中调用这些 NSString 的方法，将不用进行转换。
 
 更多关于在 Foundation 和 Cocoa 中使用 String 的信息请查看 Using Swift with Cocoa and Objective-C (Swift 4)。
 */

//: ## 字符串字面量
/*:
 你可以在代码里使用一段预定义的字符串值作为字符串字面量。字符串字面量是由一对双引号包裹着的具有固定顺序的字符集。
 
 字符串字面量可以用于为常量和变量提供初始值：
 
     let someString = "Some string literal value"
 
 注意 someString 常量通过字符串字面量进行初始化，Swift 会推断该常量为 String 类型。
 */
let someString = "Some string literal value"
//: ## 多行字符串字面量
/*:
 如果你需要一个字符串是跨越多行的，那就使用多行字符串字面量 — 由一对三个双引号包裹着的具有固定顺序的文本字符集：
 
     let quotation = """
     The White Rabbit put on his spectacles.  "Where shall I begin,
     please your Majesty?" he asked.
 
     "Begin at the beginning," the King said gravely, "and go on
     till you come to the end; then stop."
     """
 
 一个多行字符串字面量包含了所有的在开启和关闭引号（"""）中的行。这个字符从开启引号（"""）之后的第一行开始，到关闭引号（"""）之前为止。这就意味着字符串开启引号之后（"""）或者结束引号（"""）之前都没有换行符号。（译者：下面两个字符串其实是一样的，虽然第二个使用了多行字符串的形式）
 
     let singleLineString = "These are the same."
     let multilineString = """
     These are the same.
     """
 
 如果你的代码中，多行字符串字面量包含换行符的话，则多行字符串字面量中也会包含换行符。如果你想换行，以便加强代码的可读性，但是你又不想在你的多行字符串字面量中出现换行符的话，你可以用在行尾写一个反斜杠（\）作为续行符：
 
     let softWrappedQuotation = """
     The White Rabbit put on his spectacles.  "Where shall I begin, \
     please your Majesty?" he asked.
 
     "Begin at the beginning," the King said gravely, "and go on \
     till you come to the end; then stop."
     """
 
 为了让一个多行字符串字面量开始和结束于换行符，请将换行写在第一行和最后一行，例如：
 
     let lineBreaks = """
 
     This string starts with a line break.
     It also ends with a line break.
 
     """
 
 */
let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""
//: ## 字符串字面量的特殊字符
/*:
 字符串字面量可以包含以下特殊字符：
 - 转义字符 \0(空字符)、\\(反斜线)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)。
 - Unicode 标量，写成 \u{n}(u 为小写)，其中 n 为任意一到八位十六进制数且可用的 Unicode 位码。
 
 特俗字符示例：
 
     let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
     // "Imageination is more important than knowledge" - Enistein
     let dollarSign = "\u{24}"             // $，Unicode 标量 U+0024
     let blackHeart = "\u{2665}"           // ♥，Unicode 标量 U+2665
     let sparklingHeart = "\u{1F496}"      // 💖，Unicode 标量 U+1F496
 
 多行字符字面量里可以直接说引号 `"` ，若要使用三引号 `"""` 则需要至少一个转义符：
 
     let threeDoubleQuotes = """
     Escaping the first quote \"""
     Escaping all three quotes \"\"\"
     """
 
 */
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{1F496}"
//: ## 初始化空字符串
/*:
 创建一个空字符串，可以将空的字符串字面量赋值给变量，也可以初始化一个新的 `String` 实例：
 
     var emptyString = ""               // 空字符串字面量
     var anotherEmptyString = String()  // 初始化方法
     // 两个字符串均为空并等价。
 
 ### 字符串判空
 字符串使用属性 `isEmpty` 进行判空：
 
     if emptyString.isEmpty {
         print("Nothing to see here")
     }
     // 打印输出："Nothing to see here"
 
 */
var emptyString = ""
var anotherEmptyString = String()
//: ## 字符串可变性
/*:
 与`OC`的可变性不同，`Swift`中 `var` 声明的 `String` 变量是可变字符串，`let` 声明的 `String` 常量是不可变字符串：
 
     var variableString = "Horse"
     variableString += " and carriage"
     // variableString 现在为 "Horse and carriage"
 
     let constantString = "Highlander"
     constantString += " and another Highlander"
     // 这会报告一个编译错误（compile-time error） - 常量字符串不可以被修改。
 
 */
var variableString = "Horse"
variableString += " and carriage"

let constantString = "Highlander"
// constantString += " and another Highlander" // Error: change 'let' to 'var' to make it mutable
//: ## 字符
/*:
 `Swift` 中通过 `for-in` 循环来遍历字符串：
 
     for character in "Dog!🐶" {
         print(character)
     }
     // D
     // o
     // g
     // !
     // 🐶
 
 通过 `Character` 来使用字符；可以通过 `[Character]` 数组初始化字符串：
 
     let exclamationMark: Character = "!"
 
     let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
     let catString = String(catCharacters)
     print(catString)
     // 打印输出："Cat!🐱"
 */

//: ## 字符串拼接
/*:
 字符串可以通过运算符 `+` 、 `+=` 进行拼接；也可以通过方法 `append()` 拼接，`append()` 可以接受 `String` 和 `Character` 类型的实例作为参数：
 
     var instruction = "look over"
     instruction += string2
     // instruction 现在等于 "look over there"
 
     let exclamationMark: Character = "!"
     welcome.append(exclamationMark)
     // welcome 现在等于 "hello there!"
 
 */
var instruction = "look over"
instruction += "wooooow"

let exclamationMark: Character = "!"
instruction.append(exclamationMark)
//: ## 字符串插值
/*:
 字符串插值可以通过 `\()` 语法将任意值插入到字符串中：
 
     let multiplier = 3
     let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
     // message 是 "3 times 2.5 is 7.5"
 
 */
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
//: ## Unicode
/*:
 `Swift` 是基于 `Unicode` 构建的，这意味着，进行字符遍历的时候，我们得到的字符就是一个单元的 `Unicode` 标量：
 
     for character in "Dog!🐶" {
         print(character)
     }
     // D
     // o
     // g
     // !
     // 🐶
 
 如果想遍历其他编码的字符，可以使用 `UTF8View` 等属性进行遍历。
 */
for character in "Dog!🐶,\u{E9}\u{65}\u{301}" {
    print(character)
}
//: ## 字符串长度
/*:
 获取字符串长度，可以使用 `count` 属性获取，使用 `count` 获取的长度也是基于 `Unicode` 计算的：
 
     "Dog!🐶,\u{E9}\u{65}\u{301}".count // 8
 
 这样得到的结果可能会与 `NSString` 得到的结果不一样，`NSString` 是通过 `utf16` 编码计算的长度：
 
     "Dog!🐶,\u{E9}\u{65}\u{301}".utf16.count // 10
     ("Dog!🐶,\u{E9}\u{65}\u{301}" as NSString).length // 10
 
 */
print("Dog!🐶,\u{E9}\u{65}")
"Dog!🐶,\u{E9}\u{65}".count
"Dog!🐶,\u{E9}\u{65}\u{301}".utf16.count
("Dog!🐶,\u{E9}\u{65}\u{301}" as NSString).length
//: ## 字符串访问
/*:
 `String` 可以通过下标进行访问，根据指定的下标的值，可以获取到对应位置的字符；`Swift` 中的字符串是基于 `Unicode` 构建的，因此，`String` 的下标并不是一个确定的值，需要根据访问的编码类型来确定位移量，可以通过属性 `indices` 来获取字符串的索引范围：
 
     let greeting = "Guten Tag!"
     greeting[greeting.startIndex]
     // G
     greeting[greeting.index(before: greeting.endIndex)]
     // !
     greeting[greeting.index(after: greeting.startIndex)]
     // u
     let index = greeting.index(greeting.startIndex, offsetBy: 7)
     greeting[index]
     // a
 
     for index in greeting.indices {
         print("\(greeting[index]) ", terminator: "")
     }
     // 打印输出 "G u t e n   T a g ! "
 
 **注意：**越界访问将会触发运行时错误！
 */

//: ## 字符串插入与删除
/*:
 调用 `insert(_:at:)` 方法可以在一个字符串的指定索引插入一个字符，调用 `insert(contentsOf:at:)` 方法可以在一个字符串的指定索引插入一个段字符串：
 
     var welcome = "hello"
     welcome.insert("!", at: welcome.endIndex)
     // welcome 变量现在等于 "hello!"
 
     welcome.insert(contentsOf:" there", at: welcome.index(before: welcome.endIndex))
     // welcome 变量现在等于 "hello there!"
 
 调用 `remove(at:)` 方法可以在一个字符串的指定索引删除一个字符，调用 `removeSubrange(_:)` 方法可以在一个字符串的指定索引删除一个子字符串：
 
     welcome.remove(at: welcome.index(before: welcome.endIndex))
     // welcome 现在等于 "hello there"
 
     let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
     welcome.removeSubrange(range)
     // welcome 现在等于 "hello"
 
 */

//: ## 子字符串
/*:
 当从字符串中获取一个子字符串 —— 如，使用下标或者 `prefix(_:)` 之类的方法 —— 就可以得到一个 `SubString` 的实例，而非另外一个 `String`。`Swift` 里的 `SubString` 绝大部分函数都跟 `String` 一样，`SubString` 和 `String` 将会共享一份内存，因此，如果需要长时间引用 `SubString` 的话，尽量将 `SubString` 的部分拷贝出来：
 
     let greeting = "Hello, world!"
     let index = greeting.index(of: ",") ?? greeting.endIndex
     let beginning = greeting[..<index]
     // beginning 的值为 "Hello"
 
     // 把结果转化为 String 以便长期存储。
     let newString = String(beginning)
 
 */

//: ## 字符串比较
/*:
 `Swift` 提供了三种方式来比较文本值：字符串字符相等、前缀相等和后缀相等， `Swift` 字符串的比较是基于`Unicode`单元进行比较的，字符串判等使用 `==` 运算符：
 
     // "Voulez-vous un café?" 使用 LATIN SMALL LETTER E WITH ACUTE
     let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
 
     // "Voulez-vous un café?" 使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
     let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
 
     if eAcuteQuestion == combinedEAcuteQuestion {
         print("These two strings are considered equal")
     }
     // 打印输出 "These two strings are considered equal"
 
 前后缀比较通过方法 `hasPrefix(_:)/hasSuffix(_:)` 进行比较。
 */

//: ## 字符编码表示
/*:
 `Swift` 默认使用 `Unicode` 构建，也可以通过属性来其他编码方式：
 - `.utf8`: 获取 `UTF-8` 编码
 - `.utf16`: 获取 `UTF-16` 编码
 */
"Dog!🐶,\u{E9}\u{65}\u{301}".utf8
"Dog!🐶,\u{E9}\u{65}\u{301}".utf16
//: [下一页](@next)

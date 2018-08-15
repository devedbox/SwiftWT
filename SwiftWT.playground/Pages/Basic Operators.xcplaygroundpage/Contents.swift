//
// Basic-Operators.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 基本运算符
/*:
 `Swift`包含了大部分语言都有的运算符，如基本的算术运算符、比较运算符、逻辑运算符等，和其他语言不一样，`Swift`中赋值运算符默认没有返回，这样就避免了`==`与`=`运算符使用不当的场景；`Swift`的算术运算符会检测运算值并避免值溢出；除此之外，`Swift`还支持自定义运算符以及运算符重载，详见[高级运算符](Advanced%20Operators).
 
     let maxInt8: Int8 = Int8.max
     let overflowInt8: Int8 = Int8.max + maxInt8 // Error: Arithmetic operation '127 + 127' (on type 'Int8') results in an overflow
 */

//: ## 基础
/*:
 - 赋值运算符：`=`
 - 复合赋值运算符：`+=`、`-=`
 - 算术运算符：`+`、`-`、`*`、`/`、`%`
 - 正负运算符：`+`、`-`
 
 - Note:
 自增自减运算符自`Swift` `3.0`之后就被移除了
 */

//: ## 比较运算符
/*:
 - 等于：`==`
 - 不等于：`!=`
 - 大于：`>`
 - 小于：`<`
 - 大于等于：`>=`
 - 小于等于：`<=`
 
 - Note:
 `Swift`比较类实例是否是同一个引用需要使用恒等运算符：`===`、`!==`
 */

//: ## 逻辑运算符
/*:
 - 逻辑与：`&&`
 - 逻辑非：`!`
 - 逻辑或：`||`
 */

//: ## 位运算符
/*:
 - 按位取反：`~`
 - 按位与：`&`
 - 按位或：`|`
 - 按位异或：`^`
 - 按位右移：`>>`
 - 按位左移：`<<`
 */

//: ## 溢出运算符
/*:
 - 溢出加：`&+`
 - 溢出减：`&-`
 - 溢出乘：`&-`
 
 上溢出：
 
     var unsignedOverflow = UInt8.max
     // unsignedOverflow 等于 UInt8 所能容纳的最大整数 255
     unsignedOverflow = unsignedOverflow &+ 1
     // 此时 unsignedOverflow 等于 0
 
 下溢出：
 
     var unsignedOverflow = UInt8.min
     // unsignedOverflow 等于 UInt8 所能容纳的最小整数 0
     unsignedOverflow = unsignedOverflow &- 1
     // 此时 unsignedOverflow 等于 255
 
 */

//: ## 三元运算符
/*:
 三元条件运算符，和`C`语言一样，语法为：`true` `?` `yes` `:` `no`，三元运算符是以下代码的缩写形式：
 
     if question {
         answer1
     } else {
         answer2
     }
 */

//: ## 空合运算符
/*:
 `Swift`特有的运算符，空合运算符的作用是为可选的变量提供一个默认值，空合运算符的语法：`optionalValue` `??` `defaultValue`，等效于`optionValue` `==` `nil` `?` `optionalValue!` `:` `defaultValue`：
 
     let defaultColorName = "red"
     var userDefinedColorName: String?   //默认值为 nil
 
     var colorNameToUse = userDefinedColorName ?? defaultColorName
     // userDefinedColorName 的值为空，所以 colorNameToUse 的值为 "red"
 - Note:
 当`optionalValue`不为`nil`时，`defaultValue`不会被求值，这既是所谓的**短路求值**。
 */

//: ## 区间运算符
/*:
 区间运算符可以表示一个连续的数值区间，表示一个范围.
 */
//: ### 闭区间运算符
/*:
 闭区间运算符（a...b）定义一个包含从 a 到 b（包括 a 和 b）的所有值的区间。a 的值不能超过 b。
 
 闭区间运算符在迭代一个区间的所有值时是非常有用的，如在 for-in 循环中：
 
     for index in 1...5 {
         print("\(index) * 5 = \(index * 5)")
     }
     // 1 * 5 = 5
     // 2 * 5 = 10
     // 3 * 5 = 15
     // 4 * 5 = 20
     // 5 * 5 = 25
 */
//: ### 半开区间运算符
/*:
 半开区间运算符（a..<b）定义一个从 a 到 b 但不包括 b 的区间。 之所以称为半开区间，是因为该区间包含第一个值而不包括最后的值。
 
 半开区间的实用性在于当你使用一个从 0 开始的列表（如数组）时，非常方便地从0数到列表的长度。
 
     let names = ["Anna", "Alex", "Brian", "Jack"]
     let count = names.count
     for i in 0..<count {
         print("第 \(i + 1) 个人叫 \(names[i])")
     }
     // 第 1 个人叫 Anna
     // 第 2 个人叫 Alex
     // 第 3 个人叫 Brian
     // 第 4 个人叫 Jack
 */
//: ### 单侧区间
/*:
 闭区间操作符有另一个表达形式，可以表达往一侧无限延伸的区间 —— 例如，一个包含了数组从索引 2 到结尾的所有值的区间。在这些情况下，你可以省略掉区间操作符一侧的值。这种区间叫做单侧区间，因为操作符只有一侧有值。例如：
 
     for name in names[2...] {
         print(name)
     }
     // Brian
     // Jack
 
     for name in names[...2] {
         print(name)
     }
     // Anna
     // Alex
     // Brian
 
 半开区间操作符也有单侧表达形式，附带上它的最终值。就像你使用区间去包含一个值，最终值并不会落在区间内。例如：
 
     for name in names[..<2] {
         print(name)
     }
     // Anna
     // Alex
 
 单侧区间不止可以在下标里使用，也可以在别的情境下使用。你不能遍历省略了初始值的单侧区间，因为遍历的开端并不明显。你可以遍历一个省略最终值的单侧区间；然而，由于这种区间无限延伸的特性，请保证你在循环里有一个结束循环的分支。你也可以查看一个单侧区间是否包含某个特定的值：
 
     let range = ...5
     range.contains(7)   // false
     range.contains(4)   // true
     range.contains(-1)  // true
 
 */
//: [下一页](@next)

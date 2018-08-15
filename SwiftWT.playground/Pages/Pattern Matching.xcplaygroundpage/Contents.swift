//: [Previous](@previous)

import Foundation

//: # 模式匹配
/*:
 模式匹配是 Swift 中非常常见的一种编程模式，使用模式匹配，可以帮助我们写出简明、清晰以及易读的代码，使我们的代码变得简洁而强大。
 */
//: ## 条件判断中的模式匹配
/*:
 条件判断是我们使用最普遍的流程控制，在 Swift 中，只能接受 Bool 类型的值作为条件体；除了直接判断 Bool 值之外，我们还能使用使用条件语句进行可选绑定，这在我们开发中是非常常用的方式。
 */
//: ### 匹配枚举值
/*:
 在 Swift 中，创建的枚举类型默认是不可比较的(没有实现`Comparable`协议)，这就意味着我们不能直接使用`==`操作符来判断两个枚举值是否相等，这种情况下，需要使用模式匹配：
 */
//: 创建一个枚举类型：
enum Result {
    case success
    case failure
}
//: 初始化一个枚举值：
let result = Result.success
//: 使用模式匹配来判断创建的枚举值的值：
if case .success = result {
    print("Value of result is success.")
}
//: ### 可选绑定
//: 创建一个可选值：
let optionalInt: Int? = 1
//: 使用可选绑定的方式进行解包：
if let val = optionalInt {
    print("The value of optionalInt is \(val)")
}
func handleGuard() {
    guard let val = optionalInt else {
        return
    }
    
    print("The value of optionalInt is \(val)")
}
handleGuard()
//: 可选绑定的另外一种模式，这也是可选绑定中最基础的模式：
if case .some(let val) = optionalInt {
    print("The value of optionalInt is \(val)")
}
//: 还可以简化为：
if case let val? = optionalInt {
    print("The value of optionalInt is \(val)")
}
//: ## 循环中的模式匹配
//: 问题来了，`if` `let` 模式的可选绑定，只能实现一个可选值的绑定，如果我们需要匹配一个数组里边的可选值怎么办呢？这时候我们就不能使用 `if` `let` 的形式了，需要使用到 `if` `case` `let` 的形式
//: 创建一个包含可选值的数组：
let values: [Int?] = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
//: 进行遍历：
for val in values {
    print("Value in values is \(String(describing: val))")
}
//: 或者：
var valuesIterator = values.makeIterator()
while let val = valuesIterator.next() {
    print("Value in values is \(String(describing: val))")
}
//: 我们得到了所有的值与可选值，如果我们需要过滤可选值，我们可以这样做：
for val in values.compactMap({ $0 }) {
    print("Value in values is \(val)")
}
//: 这样做，增加了时间复杂度，需要进行两次遍历才能将数据过滤出来。我们可以使用模式匹配的方式来这样做：
for case let val? in values {
    print("Value in values is \(val)")
}
//: 或者：
valuesIterator = values.makeIterator()
while let val = valuesIterator.next(), val != nil {
    print("Value in values is \(String(describing: val))")
}
//: 这样就可以将 nil 值给过滤了，是不是很简单？还可以使用 `for` `case` 匹配枚举值数组：
let results: [Result] = [.success, .failure]
for case .success in results {
    print("Values in results contains success.")
    break
}
//: 对于复杂的枚举类型：
enum NetResource {
    case http(resource: String)
    case ftp(resource: String)
}
let nets: [NetResource] = [.http(resource: "https://www.baidu.com"), .http(resource: "https://www.apple.cn"), .ftp(resource: "ftp://192.0.0.1")]
//: 过滤 http 的值：
for case .http(let resource) in nets {
    print("HTTP resource \(resource)")
}
//: ### `for` 循环使用 `where` 从句
//: 除此之外，我们还可以在 `for` 循环后边跟上一个 `where` 从句来进行模式匹配：
for notNilValue in values where notNilValue != nil {
    print("Not nil value: \(String(describing: notNilValue!))")
}
//: 查询一个数组里边所有能被3整除的数：
let rangeValues = Array(0...999)
for threeDivideValue in rangeValues where threeDivideValue % 3 == 0 {
    print("Three devide value: \(threeDivideValue)")
}
//: 查询所有含有3的数：
for containsThree in rangeValues where String(containsThree).contains("3") {
    print("Value contains three: \(containsThree)")
}
//: ## Switch 中的模式匹配
/*:
 Switch 中的模式匹配也很常用，在 Switch 中合理地使用模式匹配可以为我们带来很多好处，可以使我们的代码更简洁，同时可以减少代码量和增加开发效率。
 */
//: ### 区间匹配
let value = 188
switch value {
case 0..<50:
    print("The value is in range [0, 50)")
case 50..<100:
    print("The value is in range [50, 100)")
case 100..<150:
    print("The value is in range [100, 150)")
case 150..<200:
    print("The value is in range [150, 200)")
case 200...:
    print("The value is in range [200, ")
default: break
}
// The value is in range [150, 200)
//: ### 匹配元组类型
/*:
 创建一个元组类型：
 */
let tuples: (Int, String) = (httpCode: 404, status: "Not Found.")
//: 进行匹配：
switch tuples {
case (400..., let status):
    print("The http code is 40x, http status is \(status)")
default: break
}
//: 创建一个点：
let somePoint = (1, 1)
//: 进行匹配：
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
//: 如上，我们在匹配的时候可以使用下划线 `_` 对值进行忽略：
switch tuples {
case (404, _):
    print("The http code is 404 not found.")
default: break
}
//: ### 在 `switch` `case` 中使用 `where` 从句
//: 在 case 中使用 where 从句可以使我们的模式匹配看起来更加精简，使匹配的模式更加紧凑：
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
//: # 总结
//: ## Swift 中模式匹配的种类
/*:
 模式匹配可以说是 Swift 中非常强大的一种编程模式，使用良好的模式匹配，可以帮助我们写出简介、优雅的代码，Swift 中的模式匹配包括以下种类：
 
 - 条件判断：`if`, `guard`
 - 可选绑定：`if` `let`, `guard` `let`, `while` `let` ...
 - 循环体：`for`, `while`, `repeat` `while`
 - `switch`
 - `do` `catch`
 */
//: ## 什么时候使用 `where` 从句？
/*:
 我们可以在前文的例子中看到，在很多进行模式匹配的地方还使用了 `where` 从句，`where` 从句的作用就相当于在模式匹配的基础上在加上条件限制，使用 `where` 从句等价于：
 */
for notNilValue in values {
    if notNilValue != nil {
        print("Not nil value: \(String(describing: notNilValue!))")
    }
}
/*:
 可以看出，使用 `where` 从句可以使我们的代码更加简洁和易读，什么时候使用 `where` ？ 或者说在哪里可以使用 `where` ？ Swift 文档中并没有对 `where` 的详细使用进行介绍，但是在实践中发现，`where` 可以使用在以下地方：
 
 - `for` 循环语句
 - `switch` 分支
 
 而对于 `if`, `guard` 与 `while` ，我们不能在其后面添加 `where` 从句，因为他们本身可以进行多个条件的组合. `where` 从句还有一个用法就是对泛型类型进行类型约束，这在泛型的章节中会有介绍.
 */
//: [Next](@next)

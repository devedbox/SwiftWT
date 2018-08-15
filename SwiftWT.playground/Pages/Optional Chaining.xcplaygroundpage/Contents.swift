//
// Optional-Chaining.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 可选链
/*:
 可选链是一种可以在当前值可能为 nil 的可选值上请求和调用属性、方法及下标的方法。如果可选值有值，那么调用就会成功；如果可选值是 nil，那么调用将返回 nil。多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为 nil，整个调用链都会失败或返回 nil。
 
 Swift 的可选链和 Objective-C 中向 nil 发送消息有些相像，但是 Swift 的可选链可以应用于任意类型，并且能检查调用是否成功。
 */

//: ## 使用可链代替强制解包
/*:
 通过在想调用的属性、方法，或下标的可选值后面放一个问号（?），即可定义一个可选链。与在可选值后面放一个叹号（!）来解包很相似。主要区别在于当可选值为空时可选链调用只会调用失败，然而强制展开将会触发运行时错误。
 
 可选链的返回结果是一个对应类型的可选值。可以利用返回值来判断可选链调用是否调用成功，如果调用有返回值则说明调用成功，返回 nil 则说明调用失败。
 
     class Person {
         var residence: Residence?
     }
 
     class Residence {
         var numberOfRooms = 1
     }
 
     let john = Person()
 
     let roomCount = john.residence!.numberOfRooms
     // 这会引发运行时错误
 
 使用可选链的方式：
 
     if let roomCount = john.residence?.numberOfRooms {
         print("John's residence has \(roomCount) room(s).")
     } else {
         print("Unable to retrieve the number of rooms.")
     }
     // 打印 “Unable to retrieve the number of rooms.”
 
 
     john.residence = Residence()
 
     if let roomCount = john.residence?.numberOfRooms {
         print("John's residence has \(roomCount) room(s).")
     } else {
         print("Unable to retrieve the number of rooms.")
     }
     // 打印 “John's residence has 1 room(s).”
 */

//: ## 通过可选链式调用访问属性
/*:
 可以通过可选链调用在一个可选值上访问它的属性，并判断访问是否成功。
 
     let john = Person()
     if let roomCount = john.residence?.numberOfRooms {
         print("John's residence has \(roomCount) room(s).")
     } else {
         print("Unable to retrieve the number of rooms.")
     }
     // 打印 “Unable to retrieve the number of rooms.”
 
 还可以通过可选链式调用来设置属性值：
 
     let someAddress = Address()
     someAddress.buildingNumber = "29"
     someAddress.street = "Acacia Road"
     john.residence?.address = someAddress
 
 */

//: ## 通过可选链式调用来调用方法
/*:
 可以通过可选链调用来调用方法，并判断是否调用成功，即使这个方法没有返回值。无返回值的函数实际为 Void ，链式调用将会返回 Void?，而不是 Void。
 
 通过判断返回值是否为 nil 可以判断调用是否成功：
 
     if john.residence?.printNumberOfRooms() != nil {
         print("It was possible to print the number of rooms.")
     } else {
         print("It was not possible to print the number of rooms.")
     }
     // 打印 “It was not possible to print the number of rooms.”
 
     if (john.residence?.address = someAddress) != nil {
         print("It was possible to set the address.")
     } else {
         print("It was not possible to set the address.")
     }
     // 打印 “It was not possible to set the address.”
 
 */

//: ## 通过可选链式调用访问下标
/*:
 通过可选链调用，我们可以在一个可选值上访问下标，并且判断下标调用是否成功：
 
     if let firstRoomName = john.residence?[0].name {
         print("The first room name is \(firstRoomName).")
     } else {
         print("Unable to retrieve the first room name.")
     }
     // 打印 “Unable to retrieve the first room name.”
 
 可选链赋值：
 
     john.residence?[0] = Room(name: "Bathroom")
 
 */
//: [下一页](@next)

//: [Previous](@previous)

import Foundation
import ObjectiveC

//: # Dynamic Swift
/*:
 众所周知，Swift 是一门静态语言，所有属性在编译期就已经确定下来了，对方法的派发是是静态完成的，类似于 C++ 的 vtable ，这样可以大幅提升 Swift 的性能，据统计，Swift 静态派发的的速度大约耗时为 `1.1` 纳秒，而 ObjC 的动态派发耗时为 `4.9` 纳秒，Swift 快大约 5 倍的时间，所以 Swift 性能比 ObjC 好，也就是因为 Swift 做了很多静态优化。
 
 我们都知道，ObjC 跟 Swift 相反，ObjC 是动态语言，所有方法、属性都是动态派发和动态绑定的，这样给我们带来很多好处，比如我们可以全局的替换一个方法，或者在运行时替换示例的类型等等。在使用 ObjC 的时候，我们可以轻易的实现 AOP 编程。
 
 我一度认为，Swift 真的就是一门静态语言，我可能是真的在内心深处不愿与去承认 Swift 的 ObjC 历史，因为我更愿意把 Swift 当做一门新语言来看待，在这样的背景下，我认为 Swift 是一门完完全全的静态语言，同时，我也认为为了使用 ObjC 运行时，我们需要在 Swift 里继承 NSObject。但是，事实发现这样的看法有问题，Swift 不是一门完完全全的静态语言，Swift 还可以做到动态派发，同时，Swift 可以不用继承 NSObject 而是而实现动态派发(这是苹果的一个彩蛋？查阅Swift文档之后发现，苹果早这么说过，但是我却选择忽略...)
 */
//: ## ObjC Runtime 做了啥
/*:
 我们都知道 ObjC Runtime 做了什么事情，他为我们提供了统一的数据结构，为我们描述了一个类、一个实例具有哪些实实在在的东西，而且，我们也很清楚的知道，ObjC 所有类都必须继承自 NSObject 。
 
 更多关于 ObjC Runtime 的东西不在本文的讨论范畴。
 */
//: ## Swift 有运行时吗?
/*:
 答案是肯定的。但是，Swift 没有提供运行时访问的 API ，而且，Swift 本身是静态语言，他的运行时和动态性八竿子打不着。幸运的是，Swift 支持动态化，什么意思呢？Swift 有它自己的运行时，用来处理纯 Swift 语言的，做的工作肯定是很多静态优化的事情，所以，如果需要支持 Swift 动态化，我们需要使用 objc 的运行时机制，而且，Swift 本身就做了对 objc 运行时的兼容。
 */
//: 这是一个 Swift 类：
public class SwiftClass {
    public var val: Int
    
    public init(
        _ val: Int)
    {
        self.val = val
    }
    
    public func echo(
        _ val: Int) -> Int
    {
        return val
    }
    
    @objc
    public dynamic func dynamicEcho(
        _ val: Int) -> Int
    {
        return val
    }
}

func objc_classes(of cls: AnyClass) -> [AnyClass] {
    var clss: [AnyClass] = []
    var cls: AnyClass? = cls
    while let _cls = cls {
        clss.append(_cls)
        cls = class_getSuperclass(_cls)
    }
    
    return clss
}
//: 创建一个实例：
let classIns = SwiftClass(110)
//: 查看一下 `classIns` 的类型：
print(objc_classes(of: object_getClass(classIns)!))
// [__lldb_expr_3.SwiftClass, SwiftObject]
//: 可以清楚的看到，`dynamicIns`在 objc 运行时里的根类是 `SwiftObject` 。这很符合我们的预期，因为 Swift 为我们兼容了从 Swift 类到 objc 运行时类的转变。
//:
//: 接下来我们看一下 SwiftObject 类的“料”:
let swiftObjectClass = objc_getClass("SwiftObject".withCString { $0 })
print(swiftObjectClass as Any)
// SwiftObject

public func objc_methods(of class: AnyClass) -> [String] {
    var count: UInt32 = 0
    let methodList = class_copyMethodList(`class`, &count)
    return (0..<count).compactMap { idx in
        methodList.map { method_getName($0.advanced(by: Int(idx)).pointee).description }
    }
}

public func objc_properties(of class: AnyClass) -> [String] {
    var count: UInt32 = 0
    let propertyList = class_copyPropertyList(`class`, &count)
    return (0..<count).compactMap { idx in
        propertyList.map { String(cString: property_getName($0.advanced(by: Int(idx)).pointee)) }
    }
}

public func objc_ivars(of class: AnyClass) -> [String] {
    var count: UInt32 = 0
    let ivarList = class_copyIvarList(`class`, &count)
    return (0..<count).compactMap { idx in
        ivarList.flatMap { ivar_getName($0.advanced(by: Int(idx)).pointee).map({ String(cString: $0) }) }
    }
}

public func objc_protocols(of class: AnyClass) -> [String] {
    var count: UInt32 = 0
    let protocolList = class_copyProtocolList(`class`, &count)
    return (0..<count).compactMap { idx in
        String(cString: protocol_getName(protocolList![Int(idx)]))
    }
}

print(objc_methods(of: swiftObjectClass as! AnyClass))
// ["class", "isKindOfClass:", "release", "isEqual:", "self", "performSelector:", "performSelector:withObject:", "performSelector:withObject:withObject:", "isProxy", "isMemberOfClass:", "conformsToProtocol:", "respondsToSelector:", "retain", "autorelease", "retainCount", "zone", "hash", "superclass", "description", "debugDescription", "dealloc", "methodForSelector:", "doesNotRecognizeSelector:", "allowsWeakReference", "retainWeakReference", "_isDeallocating", "_tryRetain", "isNSArray__", "isNSNumber__", "isNSDictionary__", "isNSSet__", "isNSOrderedSet__", "isNSString__", "_cfTypeID", "isNSValue__", "isNSDate__", "isNSData__", "isNSObject__", "_copyDescription", "isNSCFConstantString__", "isNSTimeZone__"]
print(objc_properties(of: swiftObjectClass as! AnyClass))
// ["hash", "superclass", "description", "debugDescription"]
print(objc_ivars(of: swiftObjectClass as! AnyClass))
// ["isa", "refCounts"]
print(objc_protocols(of: swiftObjectClass as! AnyClass))
// ["NSObject"]

print(objc_methods(of: object_getClass(classIns)!))
//: 所以说，SwiftObject 实现了协议 `NSObject` 的一个 ObjC 运行时类型，那么，SwiftObject 支持动态派发吗？我们来试试看：
print((classIns as AnyObject).perform?(NSSelectorFromString("class")) as Any)
// print((classIns as AnyObject).perform?(NSSelectorFromString("echo:"), with: 110)) // Error.
print((classIns as AnyObject).perform?(NSSelectorFromString("dynamicEcho:"), with: 110) as Any)
//: 可以看到，SwiftObject 在 ObjC 运行时实现了 NSObject 的基础协议的方法，并且我们可以通过运行时动态派发在 Swift 对象上调用 NSObject 协议里的方法，以及我们声明了 `@objc` `dynamic` 的方法或者属性。也就是说，Swift 声明的类型在 ObjC 运行时中还是以兼容 ObjC 的形式存在，只不过在 Swift 中声明的方法或者属性会被 Swift 做静态优化以提升性能，被静态优化的方法和属性不会在 ObjC 运行时中出现。
//:
//: 再来看一个例子：
public struct SwiftStruct {
    public let val: Int
    
    public func echo(
        _ val: Int) -> Int
    {
        return val
    }
    
    // @objc // Error: @objc can only be used with members of classes, @objc protocols, and concrete extensions of classes
    // public dynamic func dynamicEcho( // Error: Only members of classes may be dynamic
    //     _ val: Int) -> Int
    // {
    //     return val
    // }
}

public enum SwiftEnum {
    case a, b, c
}

let structVal = SwiftStruct(val: 110)
let stdIntVal = 110
let stdBoolVal = false
let stdArrVals = ["1", "2", "3"]
let stdDicVals = ["1": 1, "2": 2]
let stdSetVals: Set<Int> = [1, 2, 3]

print(objc_classes(of: object_getClass(structVal)!))
// [_SwiftValue, NSObject]
print(objc_methods(of: object_getClass(structVal)!))
// ["isEqual:", "hash", "description", "debugDescription", "dealloc", "copyWithZone:", "_swiftTypeMetadata", "_swiftTypeName", "_swiftValue"]
print(objc_classes(of: object_getClass(SwiftEnum.a)!))
print(objc_classes(of: object_getClass(stdIntVal)!))
// [__NSCFNumber, NSNumber, NSValue, NSObject]
print(objc_classes(of: object_getClass(stdBoolVal)!))
// [__NSCFBoolean, NSNumber, NSValue, NSObject]
print(objc_classes(of: object_getClass(stdArrVals)!))
// [Swift._SwiftDeferredNSArray, Swift._SwiftNativeNSArrayWithContiguousStorage, Swift._SwiftNativeNSArray, _SwiftNativeNSArrayBase, NSArray, NSObject]
print(objc_classes(of: object_getClass(stdDicVals)!))
// [Swift._SwiftDeferredNSDictionary<Swift.String, Swift.Int>, Swift._SwiftNativeNSDictionary, _SwiftNativeNSDictionaryBase, NSDictionary, NSObject]
print(objc_classes(of: object_getClass(stdSetVals)!))
// [Swift._SwiftDeferredNSSet<Swift.Int>, Swift._SwiftNativeNSSet, _SwiftNativeNSSetBase, NSSet, NSObject]
//: 可以看出，Swift 的结构体类型在 ObjC 的都有兼容的类型，并且所有的类型的根类型都是 ObjC 的 NSObject 类。我们同样可以对这些类型进行动态派发调用 ObjC 运行时注册的方法，但是对我们自己定义的 Swift 方法就没办法进行动态派发，因为 Struct 结构体类型不支持 `dynamic` .
//:
//: 对于 Swift 可桥接类型，如 Int, Double, Set, Array, Dictionary ，他们在 ObjC 运行时里都有对应的桥类型，比如 Int/Double 对应了 NSNumber 类型，Set 对应了 NSSet 类型，Array 对应了 NSArray，Dictionary 对应了 NSDiction，对于这些类型，我们应该尽量避免桥接使用，因为桥接就没有了 Swift 的静态优化。
//:
//: 而对于 Swift 专有的类型而言，它们在 ObjC 运行时里边类都是 `_SwiftValue`，这个类集成自 NSObject 并且提供了部分 Swift 相关的方法，用来供 Swift 优化使用。
//: ### 为 Swift 类型提供动态派发的能力
//: 我们以结构体举例，新建一个结构体：
public struct DynamicStruct {
    public var val: Int
    
    public func echo(
        _ val: Int) -> Int
    {
        print("Calling echo...")
        return val
    }
    
    internal func dispatchEcho(
        _ obj: AnyObject, val: Int) -> Int
    {
        return echo(val)
    }
}
//: 生成一个实例：
let dynamicVal = DynamicStruct(val: 110)
//: 为 `dynamicVal` 添加 ObjC 运行时方法：
let block: @convention(block) (AnyObject, Int) -> Int = dynamicVal.dispatchEcho
let imp = imp_implementationWithBlock(unsafeBitCast(block, to: AnyObject.self))
let dynamicValCls = object_getClass(dynamicVal)!
class_addMethod(dynamicValCls, NSSelectorFromString("objcEcho:"), imp, "@24@0:8@16")
//: 使用 ObjC 动态派发：
print((dynamicVal as AnyObject).perform(NSSelectorFromString("objcEcho:"), with: Int(1000))!.takeRetainedValue())
//: 结果如我们所期望的一样，为结构体类型添加了 ObjC 动态派发的能力。
// Calling echo...
// 1000
//: ### 我们回到正题
/*:
 Swift 有运行时吗？有，所有 Swift 中的类型(结构体、枚举、类)在 ObjC 运行时中都有对应的类来描述，这个一直困惑我的问题总算有了答案。
 
 ### 做一个总结
 Swift 是一门静态语言，所有在 Swift 中声明的方法和属性都是静态编译期就确定了的，同时，Swift 也支持动态绑定和动态派发，只需要将`class`里的属性或方法声明为`@objc` `dynamic`即可，此时，Swift 的动态特性将使用 ObjC Runtime 来实现，完全兼容 ObjC 。
 */
//: ## @objc、@objcMembers、dynamic介绍
/*:
 前面提到，Swift的动态派发依赖 ObjC 的运行时系统，为了将 Swift 的方法属性甚至类型暴露给 ObjC 使用，我们需要声明为 @objc ，此时可以在 ObjC 中访问，但是，声明为 @objc 的属性或方法有可能会被 Swift 优化为静态调用，不一定会动态派发，如果要使用动态特性，需要声明 dynamic ，这样才能完全的使用动态特性。@objcMembers 和 @objc 差不多，区别是：
 
 - @objcMembers 声明的类会隐式地为所有的属性或方法添加 @objc 标示
 - 声明为 @objc 的类需要继承自 NSObject ，而 @objcMembers 不需要继承自 NSObject
 
 几个需要注意的点：
 
 - 在 Swift 3.x 中，继承自 NSObject 的类会隐式地为所有 public 的属性或方法添加 @objc 标示，private 的b属性或方法则需要手动添加
 - 在 Swift 4.x 中，继承自 NSObject 的类不会隐式添加 @objc
 - @objc 还可以修改暴露给 ObjC 的属性或方法名：`@objc(Name)`
 */
//: ## Swift 的窘境
/*:
 Swift 被设计为一门静态语言，却无奈需要兼容历史 Cocoa 库，始终摆脱不掉 ObjC 的包袱，这种情况在未来的几年内应该是 Swift 的常态，这样的一种妥协，为我们提供了 Swift 做动态化的思路。
 
 虽然，Swift 兼容了 ObjC 运行时，但是，我们不知道 Swift 这么做的目的是什么，是为了兼容历史的 Cocoa 库？还是说这是 Swift 给我们的彩蛋？
 
 也许，这是 Swift 给我们的彩蛋，甚至，未来 Swift 会给我们开放更多动态化的能力。
 */
//: ## AOP 的可能
/*:
 也正是 Swift 兼容了 ObjC 运行时，为我们实现 Swift 平台的 AOP 提供了可能性。AOP 的实现依赖于 intercept pattern ，Swift 支持两种方法调用的方式，静态调用和动态派发，因此，要在 Swift 中实现方法拦截，要么编译器提供支持，否则的话就只有着手于运行时，而 Swift 中所有的类型，都为我们兼容了 ObjC 运行时。
 */
//: [Next](@next)

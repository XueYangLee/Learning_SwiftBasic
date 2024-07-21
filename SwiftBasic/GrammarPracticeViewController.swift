//
//  GrammarPracticeViewController.swift
//  BaseTools_Swift
//
//  Created by 李雪阳 on 2021/7/30.
//

import UIKit

class GrammarPracticeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        loopPractice()
//        stringPractice()
//        arrayPractice()
//        dictionaryPractice()
//        boolPractice()
//        DPrint(add(num: 1,2,3))
        
//        blockPractice()
//        enumPractice()
        structClassPractice()
    }
    
    //MARK: - 循环
    func loopPractice()  {
        let index = 9
        assert(index > 8, "数值过小")
         
        let array = ["ha","xa","bo","wo","fa","sa"]
        
        for i in 0..<array.count {
//            DPrint("\(i),\(array[i])")
        }
        
        for i in array {
            
        }//"ha"
        
        array.forEach { i in
            if i == "xa" {
                return
            }
            DPrint("\(i)")
        }//"ha","bo","wo","fa","sa"
        
    }
    
    //MARK: - 可选型 类型转换
    func optionPractice() {
        var string : String? = nil
        
        let result = string ?? "result"//如果string有值，就强制解包并返回，如果没有值，就返回右边的值
        
        var name:Optional<String> = "zhangsan"
        name=nil
        
        if let n = name {
            DPrint(n)
        }
        
        guard let name = name else { return }
        
        
        var a=20
        var b=Double(a)
        
        var str="年龄\(a)岁"
        
        
        let array:[Any]=[12,"zhangsan"]
        let aa = array.first as? Int//类型转换  可为nil
        let ab = array.last as! String//类型转换 确定类型
        DPrint("aa:\(aa)ab:\(ab)")
        
    }
    
    //MARK: - 字符串
    func stringPractice() {
        let string = "stringTest"
        
        for c in string {
//            DPrint(c)
        }
        
        for (index, value) in string.enumerated() {
//            DPrint("\(index),\(value)")
        }
        
        let str = "string" + "append"
        DPrint("\(str)")
        var str1 = "string"
        DPrint("\(str1.appending("append1"))")
        
        var text = "stringModify"
        let a = text.removeFirst()//s
        let b = text.dropFirst()//ringModify
        DPrint("remove:\(text),drop:\(b)")
        
        
        let splitStr = "split$String||Test"
        DPrint("component:\(splitStr.components(separatedBy: "||")),split:\(splitStr.split(separator: "$"))")//字符串分割
        let replace = splitStr.replacingOccurrences(of: "||", with: "**")//字符串替换
        DPrint("replace:\(replace)")
        
        
        var extract = "Hello World"
        
        let indexStart = extract.index(extract.startIndex, offsetBy: 2)
        let indexEnd = extract.index(extract.endIndex, offsetBy: -3)//获取字符串区间位置
        
        DPrint(extract[indexStart...indexEnd])
        
        
        // 创建AttributedString
        if #available(iOS 15, *) {
            var attributestr = AttributedString("WWDC21")
            // 颜⾊
            attributestr.foregroundColor = .systemBlue
            // 字体
            attributestr.font = .body.bold().italic()
            // 下划线
            attributestr.underlineStyle = .init(pattern: .dash, color: .red)
            // 删除线
            attributestr.strikethroughStyle = .init(pattern: .dot, color: .green)
            // 筛选字串设置特殊属性
            if let range = attributestr.range(of: "WWDC") {
             attributestr[range].foregroundColor = .systemRed
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    //MARK: - 数组
    func arrayPractice() {
        var arrayInit : [String] = [String]()
        arrayInit.insert("init", at: 0)
        
//        var array : [Any] = []
        var array = [Any]()
        array = [1,2,3,4,5]
        array.append("text")//添加
//        array.reverse()//倒序
            
        DPrint("contains:\(array.contains(where: { $0 as! Int > 3}))")
        DPrint("satisfy:\(array.allSatisfy({$0 as! Int > 4}))")
        
        DPrint("first:\(array.first(where: {$0 as! Int > 1}))")
        DPrint("firstIndex:\(array.firstIndex(where: {$0 as! Int > 3}))")
        
        for (i, name) in array.enumerated() {//遍历元素及下标
            DPrint("index:\(i),name:\(name)")
        }
        
        let removeArr = array.removeLast()
        DPrint("remove:\(removeArr)")
        
        let popArr = array.popLast()//可为空数组
        
        for (i, v) in array.enumerated().reversed() {
            if i == 3{
                array.remove(at: i)
            }
        }
        
        DPrint("filter\(array.filter({$0 as! Int != 3}))")
         
        DPrint("array:\(array)")
        
        let appendArray = ["a","b","c"]
        let resultArray = array + appendArray
        DPrint("result: \(resultArray)")
    }

    //MARK: - 字典
    func dictionaryPractice() {
        var dictionary = [String:Any]()
        dictionary.updateValue("text", forKey: "key1")//字典添加更新
        
        DPrint("dic:\(dictionary)")
        
        var dic : [String:Any] = ["name":"zhangsan", "age":18]
        dic["sex"]="男"//字典添加
        
        for (key,value) in dic {
            DPrint("key:\(key) value:\(value)")
//            dictionary[key]=value//a字典添加进b字典
        }
        
    }
    
    
    func boolPractice() {
        var isSwift = true
        
        isSwift = !isSwift
        print(isSwift)
    }
    
    //MARK: - 函数
    func addNum(num1 a:Int, num2 b:Int=10) -> Int {//参数可给任意默认值  /[num1 a]部分即为形式参数
        return a+b
    }
    
    
    func add(num:Int...) -> Int {//可变参数，参数必须相同类型，  ... 为可变参数  此时num代表的事数组 //add(num: 1,2,3)
        var tmp = 0
        for i in num {
            tmp += i
        }
        return tmp
    }
    
    func swapTwoNums(a: inout Int, b: inout Int)  {//引用类型 想改变外部值则需要传递变量地址  inout
        let tmp = a
        a = b
        b = tmp
    }
    /*
     var a=10;   var b=20
     swapTwoNums(a: &a, b: &b)//参数前加&符号代表传入的是地址而不是值   inout对应&
     */
    
    //（Int）-> Int 即可视为函数
    // 数组字典为值类型   函数为引用类型 （Int,Int）-> Int
    func funcType()  {//函数类型
        var mathFunc:(Int,Int)->Int = addNum//定义函数类型
        mathFunc(10,20)//使用函数名称
        
        /*
         //addNum(num1: 1, num2: 2)
         let a = addNum
         a(1,2  )
         */
        
        printResult(a: 10, b: 20, calculateMethod: addNum)//函数作为参数
        let funcA = getResult(a: 10)
        funcA(10,20)
    }
    
    func printResult(a:Int, b:Int, calculateMethod:(Int,Int)->Int) {//函数作为参数
        DPrint(calculateMethod(a,b))
    }
    
    func getResult(a:Int) -> (Int,Int)->Int {//函数作为返回值
        if a>10 {
            return addNum
        }
        return addNum
    }
    
    
    //MARK: - 闭包
    //返回值若为 -> T 一般指泛型，不确定类型
    func square(num:Int) -> Int {//函数实例
        return num*num
    }
    
    func blockPractice() {
        //闭包  匿名函数// 对应函数实例
        var number = 10
        let squareBlock = { (num:Int)->Int in//此时的in就代表着函数返回值后的{}
            return num*num*number//闭包内可以补货储存上下文中的变量常量，即闭合并包裹那些常量和变量
        }
        square(num: 2)
        squareBlock(3)//调用区别 （逃逸闭包结果迷惑时可参考）
        
        //MARK: 闭包表达式
        /*闭包表达式
         //表达式由{}开始， 由in关键字降闭包分割参数与返回体，闭包体 /形式参数不能提供默认值，其他和函数一样
         {(parameters) -> (return type) in
            statments
         }
         */
        
        //闭包原始写法
        let a = getNewList(score: [65,75,85,95], op: {(num:Int)->Bool in return num>70})//{(num:Int)->Bool in return num>70} 作为闭包（匿名函数）使用，(num:Int)->Bool 为参数与返回值， return num>70 为返回体
        DPrint(a)
        
        let b = getNewList(score: [65,75,85,95], op: {num in num>70})
        /*1.省略->与返回类型 省略->Bool（根据闭包体可以推断返回值是一个bool）
          2.省略参数类型和括号（根据函数调用闭包传入的参数可推断闭包的参数类型是int）
          3.省略return关键字（在闭包只有一句执行语句时，return关键字可以省略，称之为单行闭包）*/
        
        let c = getNewList(score: [65,75,85,95], op: {$0>70})
        /*4.参数名称缩写，省略参数声明和in ，改为 $0 和 $1
          $ 作为闭包提供的隐式访问参数的方法  $0取第一个参数 $1取第二个参数 依此类推
          即$为参数名称的缩写，直接通过$0 $1 来顺序调用闭包的参数*/
        DPrint(c)
        
        
        //MARK: 尾随闭包
        /*尾随闭包
          1.尾随闭包是一个书写在函数括号之后的闭包表达式，是函数的最后一个参数
          2.调用时，函数的 可之前置到倒数第二个参数末尾，后面的参数直接使用{//执行代码} ，形式参数标签也随之省略
          3.只有一个参数，且该参数是闭包时，函数的() 可以省略
          4.将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增强函数的可读性
          5.多尾随闭包中的第一个闭包的标签会被强制省略!
         */
        let d = getNewList(score: [65,75,85,95]) { num in//尾随闭包理解为闭包为函数最后一个参数时可以单另出来写{//执行代码}内容
            num>70
        }
        let e = getNewList(score: [65,75,85,95]) {$0>70}
        DPrint(e)
        
        //MARK: 逃逸闭包
        /*逃逸闭包 可视为oc中的异步block调用
          1.闭包作为一个参数传递给一个函数，且闭包在函数执行完之后再调用。
          2.可以在函数中将逃逸闭包赋值给一个类的成员变量或者保存在一个数组中以备后续调用。
          3.声明一个接受闭包作为形式参数的函数时，在形式参数的类型之前加上 @escaping 来表明闭包是允许逃逸的。
          4.逃逸闭包常用于异步回调。
          5.捕获了inout参数的闭包不允许逃逸
         */
        noexcapeClosure {
            DPrint("非逃逸闭包结果显示")
        }
        excapeClosure { num in
            DPrint("逃逸闭包结果\(num)")
        }
        
        
        //MARK: 自动闭包
        /*自动闭包
         1.一种自动创建的闭包，用于包装函数参数的表达式
         2.不接受任何参数，返回值类型为包装在其中的表达式的值类型
         3.在形式参数的类型之前加上 @autoclosure 关键字进行标识
         */
        autoBlock(judge: 2>1)//可理解为参数为judge:Bool  不过bool的判断是自己单独处理的
        
        //MARK: 循环引用
        /*循环引用
         weak 对当前控制器使用弱引用，但是因为self 可能有值也可能没有值，因此weakSelf 是一个可选类型，在真正使用时可以对其强制解包
         unowned 表示即使它原来引用的对象被释放了，仍然会保持对被已经释放了的对象的一个无效的引用，它不能是可选类型值，也不会被指向nil
         weak unowned都可解决循环引用
         1. weak修饰的属性，只能是变量，同时只能是可选型。
         2. unowned修饰的属性不能是可选型。
         3. weak属性初始化后也可以为nil ，但unowned 属性初始化后一定都有值。
         4. weak比unowned 更安全。
         5. 比weak 性能更好
         */
    }
    
    func getNewList(score:[Int], op:(Int)->Bool) -> [Int] {//闭包操作函数，实例使用
        var tmp:[Int] = [Int]()
        for item in score  {
            if op(item) {
                tmp.append(item)
            }
        }
        return tmp
    }
    
    
    func noexcapeClosure(comp:()->Void) {//非逃逸闭包
        comp()
    }
    
    func excapeClosure(comp:@escaping (Int)->Void) {//逃逸闭包
        DPrint("函数开始")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            comp(10)//可视为oc的block结果返回
        }
        DPrint("函数结束")
    }
    
    func autoBlock(judge:@autoclosure ()->Bool) {//自动闭包 不接受任何参数，返回值类型为包装在其中的表达式的值类型。 可理解参数为 judge:Bool
        if judge() {
            DPrint("true")
        }else{
            DPrint("false")
        }
    }
    
    //MARK: - 枚举
    
    enum EnumExample {
        //方式1
        case enumExampleCase1
        case enumExampleCase2
        //方式2
        case North, South, East, West
    }

    enum EnumValueType : Int,CaseIterable {//oc枚举是整数有默认原始值，Swift没有原始值，但可以定义/CaseIterable来允许枚举被遍历,Swift 会暴露一个包含对应枚举类型所有情况的集合名为allCases ，通过它可以将枚举的所有情况包进一个集合中
        case EnumValue1 = 0 //等于号后赋的值为原始值
        case EnumValue2 = 1
    }
    
    enum EnumRelateType {//关联值 将枚举的成员值跟其他的类型关联存储， 在成员值后面加上 (类型)
        case scoreNumber(score:Double)
        case scoreLetter(score:String)
        // case abc(argv: Int...) // 枚举定义时的关联值如果为可变参数 Swift 5 之前这样定义
        case abc(argv: [Int])
    }
    
    func enumPractice() {
        let enumExam = EnumExample.enumExampleCase1
        
        let defaultEnum = EnumValueType.EnumValue1
        switch defaultEnum {
        case .EnumValue2:
            DPrint("推断省略")
        default:
            break
        }
        
        let enumValue = EnumValueType.EnumValue1.rawValue
        DPrint(enumValue)
        
        let enumValueInfer = EnumValueType(rawValue: 1)//选取某一原始值的枚举  EnumValue2
        
        for item in EnumValueType.allCases {//遍历枚举方式
            
        }
        
        // 枚举关联值使⽤
        // number 接收⼀个Double类型的数据，传98.5
        var score: EnumRelateType = .scoreNumber(score: 98.5)
        // letter 接收⼀个String类型的数据，传优
        score = .scoreLetter(score: "优")
    }
    
    func getEnumRelateType() -> EnumRelateType {
        return .abc(argv: [0,1,2])
    }
    
    
    //MARK: - 结构体、类使用
    func structClassPractice() {
        //struct
        
        var stu=Student()
        DPrint(stu.name)
        stu.say()
        //所有的结构体都有一个自动生成的成员构造函数 来实例化结构体，可以使用它来初始化所有的成员属性
        var stu2=Student(name: "lisi", age: 20, sex: "女")
        DPrint(stu2.name)
        //如果结构体的属性有默认值，那么该属性在实例化的时候变成可选
        var stu3=Student(name: "wangwu")
        DPrint("\(stu3.name)\(stu3.age)")
        
        // 值类型拷⻉  值类型见末尾说明
        var stu4=stu2
        // 此时改变stu4并不会改变stu2的值
        stu4.name="zhaoliu"
        
        //CGRect CGSize CGPoint为常见结构体
        
        //属性
        stu.chineseScore=95
        stu.mathScore=90
        DPrint(stu.averageScore)
        stu.averageScore=90//set方式
        //类属性访问
        Student.courseCount
        //属性监听
        stu.favor="英语"
        
        //MARK: 特征运算符
        /*特征运算符
         因为类是引用类型，可能有很多常量和变量都是引用到了同一个类的实例。有时候需要找出两个常量或者变量是否引用自同一个实例，Swift 提供了
         两个特征运算符来检查两个常量或者变量是否引用相同的实例。
         相同于 ===
         不同于 !==
         
         注意：结构体无法用 ==（!=） 和 ===(!==) 来判断是否相等。
         */
        
        
        //class
        
        var per=Person()
        per.age=20
        Person.study()
        
        //引用类型 指向原来的对象
        var per2=per
        // 对p2的修改会影响原来的p1
        per2.age=30
        
        let bool = per === per2//true
        
        var per3=Person()
        let bool2 = per !== per3//true
        
    }
    
    
    //MARK: - 泛型
    /*
     定义时使用一些以后才指定的类型，但在使用时必须指明这些类型的一种编程范式称为泛型，其主要目的是加强类型安全及减少类型转换，可以避免编写重复代码，使代码更灵活和可复用
     类型参数指定并命名一个类型占位符，并用<> 包裹，一般放在结构体、类或者函数名后面，如上面案例中的<T> ，这里的T 就是类型占位符，这个符号可以是任意的，但一般取有意义的名字。类型参数中的类型占位符在使用的时候会被真正的类型替代，如果传递的是Int ，就替换为Int ，如果传入的是Double 类型就替换为Double ，依此类推
     */
    // 泛型函数
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    //类型约束指的是类型参数必须继承自特定类，或者遵守一个特定的协议或协议组合   必须是类或者协议，结构体不⾏ UITableView是类，UITableViewDataSource是协议
    func showResult<T: UITableView, U: UITableViewDataSource>(class: T, protocol: U) {
    }
    
    //typealias是用来为已经存在的类型重新定义名字的 如将(U, U) -> Bool定义为block   将CGPoint可定义为Location一样
    // 给带有泛型的闭包定义⼀个别名
    typealias Block<U> = (U , U) -> Bool
    // ⽐较两个数的⼤⼩，返回⼀个Bool值
    func compare<T: Comparable>(number1: T, number2: T, algorithm: Block<T>) -> Bool {
        algorithm(number1, number2)
    }
    
    
    //MARK: - 异常
    /*
     Error是一个空的协议，它功能是告诉编译器，某个类型可以用来表示一个异常。
     通常使用enum 来定义异常的各种可能性。
     使用throws 关键字来标记一个函数应该抛出异常。
     使用throw 关键字来抛出异常
     */
    // 定义异常
    enum FileReadError: Error {
        case FileError
        case FileISNull
        case FileNotFound
    }
    // 改进函数，抛出异常
    func readFileContent(filePath: String) throws -> String {
        // 1.filePath为""
        if filePath == "" {
            throw FileReadError.FileISNull
        }
         
        // 2.filePath有值，但是没有对应的⽂件
        if filePath != "/User/Desktop/123.plist" {
            throw FileReadError.FileNotFound
        }
         
        // 3.取出其中的内容
        return "FileSuccess"
    }
    
    
    func ErrorPractice() {
        //处理异常
        do {
            
            //defer 提供了一种延时调用的方式，所以一般会被用来做资源释放或者销毁 虽然写在前⾯ 但后执⾏
            defer {
                DPrint("执⾏defer代码块")
            }
            
            let file = try readFileContent(filePath: "abc")
            DPrint(file)
        } catch FileReadError.FileError{//catch 后面可以捕获多个异常的值 同时处理
            DPrint("出现错误")
        } catch {
            // 有⼀个隐含参数 error
            DPrint(error)
        }
        
        
        //try? 方式处理  如果调用的函数抛出了异常，则会自动返回 ；如果没有异常，则返回带有值的可选类型
        // 最终返回结果为⼀个可选类型，所以可以直接⽤ if let 隐式解包
        let file = try? readFileContent(filePath: "abc")
    }
    
    //MARK: - Result类型
    /*
     接收两个泛型参数，一个为Success ，一个为Failure ，但是Failure 必须遵守Error 协议。
     Success：正确执行的值。
     Failure：出现问题时的错误值。
     get()：获取Result 包裹的真正的值。如果成功，返回正确执行的结果；如果异常，返回出现问题时的错误信息
     
     public enum Result<Success, Failure> where Failure: Error {
         case success(Success)
         case failure(Failure)
     }
     */
    
    func readFileContentResult(filePath: String) -> Result<String, FileReadError> {
        if filePath == "" {
            return .failure(.FileISNull)
        }
         
        if filePath != "/User/Desktop/123.plist" {
            return .failure(.FileNotFound)
        }
         
        return .success("FileSuccess")
    }
    
    func ResultPractice() {
        let result = readFileContentResult(filePath: "")
        
        // ⽅式⼀：直接通过get获取值，前⾯2种结果为nil，后⾯⼀个为123
        try? result.get()
        
        // ⽅式⼆：利⽤switch case获取值并进⼀步处理
        switch result {
        //case .success(let content):
        case let .success(content):
            DPrint("content:\(content)")
            
        //case .failure(let error):
        case let .failure(error):
            switch error {
            case .FileError:
                DPrint("")
            case .FileISNull:
                DPrint("")
            case .FileNotFound:
                DPrint("")
            }
        }
    }
    
    //MARK: - 元类型、.self与Self
    /*
     元类型（Metatype）：可以理解为类型的类型，可以通过 类型.Type 定义。既然是类型，就可以定义变量或者常量。
     如何得到这种类型？需要通过 类型.self 。（通过 type(of: ) 获取对象的类型）
     */
    func MetatypePractice() {
        var a=20
        type(of: a)//Int.Type
        
        let p=Person.self//Person.Type
        p.study()
        
        
        /*Self  方法的返回值可以声明为 ，表示当前上下文中的某种类型。  用于协议中限制相关的类型 协议中的Self 不仅指的是遵守该协议的类型本身，
         也包括了该类型的子类
         
         // 限定协议遵守者的类型为UIView及其⼦类
         protocol myProtocol where Self: UIView {
          func method()
         }
         */
    }
    
    //MARK: - @objc关键字
    /*
     OC混编中需要将暴露给 Objective-C 使用的类，属性和方法的前面加上
     Swift使用场景
     1. #selector 中调用的方法需要在方法前声明 @objc
     let button = UIButton(type: .contactAdd)
     button.addTarget(self, action: #selector(click), for: .touchUpInside)
     @objc func click()
      
     2. 协议的方法可选时，协议和可选方法前要用 @objc 声明
     @objc protocol OptionalProtocol {
      @objc optional func optionalMethold1()
     }
     
     3. 用 weak 修饰协议时，协议前面要用 @objc 声明。因为 Swift 的 protocol 可以被 struct 或是 enum 这样的值类型遵守，而这些是不通过引用计数来管理内存的，所以就不能用 weak 这样的 ARC 的概念来进行修饰
     
     4. 扩展前加上 @objc，那么里面的方法都会隐式加上 @objc
     @objc extension Person {
      func eat() { } // 包含隐式的 @objc
     }
     
     只要在类上加 @objcMembers ，则其及其子类、扩展中的属性和方法都会隐式的加上 @objc 。如果不想给扩展中的方法隐式加上 @objc ，可以用 @nonobjc 修饰扩展或者扩展中的某个方法
     @objcMembers
     class Person {
      func work() {}
     }
     */
    
    //MARK: - where关键字
    func wherePractice() {
        
        //用于条件筛选（条件过滤）
        let names = ["王⼩⼆", "张三", "李四", "王五"]
        for name in names {
            switch name {
            // 筛选数据
            case let x where x.hasPrefix("王"):
                DPrint("姓王的有：\(x)")
            default:
                DPrint("你好，\(name)")
            }
        }
        
        let array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        // 循环后⾯直接进⾏数据筛选
        for value in array where value % 2 == 0 {
            DPrint(value)
        }
        
        array.filter { item in
            item % 2 == 0
        }.forEach { item in
            DPrint(item)
        }
        
        
        /*
         // 扩展协议，并⽤where约束遵守者必须是SuperClass及其⼦类
         extension SomeProtocol where Self: SuperClass{}
         
         // 与泛型的类型约束异曲同⼯
         // 推荐使⽤类型约束
         func method<T>(num: T) where T: SomeProtocol
         
         */
    }
    
    
    //MARK: - Key Path
    /*提供了一种机制来间接获取和设置属性值，而不是通过直接赋值的方式
     Key Path的语法为 \Type.property.property...
     
     类属性必须继承字NSObject，否则不能用
     那些属性可以通过KeyPath操作，就必须在前面加上 @objc
     */
    func keyPathPractice() {
        var stu=Student()
        stu.name="zhangsan"
        
        stu[keyPath: \Student.name]//取值
        stu[keyPath: \Student.age]=18//赋值
        
        //Swift 5 为 Key Path 添加了Identity Key ，使用 \.self 获取或设置所有的属性值，结构体与类都可以使用
        // Swift 5.0，此时的stu已经是⼀个新的实例
        stu[keyPath: \.self] = Student(name: "lisi", age: 15)
        DPrint(stu.name) // lisi
    }
    
    
    //MARK: - Codable协议
    /*
     json和model 以前可以利用 KVC、JSONSerialization实现 JSON转 Model 。
     Swift 4 之后推荐使用 Codable协议，可以通过编码和解码两个操作实现JSON 与Model 之间的相互转换。
     */
    
    // JSON
    let stuJson = """
    {
    "name": "YungFan",
    "age": 17,
    "born_in": "China",
    "sex": "male"
    }
    """
    
    // 定义结构体实现Codable，⼀般情况下字段要与JSON的key⼀致，否则需要额外处理
    struct StuModel: Codable {
         let name: String
         let age: Int
         let born_in: String
         let sex: String
//        // 字段不⼀致时需要额外处理
//         // 所有属性写全，会同时影响编码与解码
//         enum CodingKeys: String, CodingKey {
//         case name
//         case age
//         case bornIn = "born_in"
//         case sex
//         }
    }
    
    func codablePractice() {
        // JSON —> 结构体/类 解码 decode
        let decoder = JSONDecoder()
        // 需要将String转Data（参考常⽤数据类型章节）
        //let stu:StuModel? = try? decoder.decode(StuModel.self, from: stuJson.data(using: .utf8)!)
        if let stu = try? decoder.decode(StuModel.self, from: stuJson.data(using: .utf8)!) {
            DPrint("name = \(stu.name) , age = \(stu.age) , bornIn = \(stu.born_in) , sex = \(stu.sex)")
        }
        
        
        // 结构体/类 —> JSON 编码 encode
        let student = StuModel(name: "zhangsan", age: 20, born_in: "AnHui", sex: "female")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let json = try? encoder.encode(student) {
            let str = String(data: json, encoding: .utf8)!
            DPrint(str)
        }
        
        // 使⽤JSONSerialization转成⼀个字典
        let jsonData = try? JSONSerialization.jsonObject(with: stuJson.data(using: .utf8)!, options: .allowFragments) as? [String: Any]
    }
}

//MARK: - 关联类型  协议的泛型
/*
 关联类型在协议中的作用是约束遵守者的元素类型，可以理解为协议的泛型。
 关联类型通过关键字associatedtype 指定
 语法： associatedtype 占位符
 */
protocol AssociateProtocol {
    // 关联类型
    associatedtype Element
     
    func method1(element: Element)
}

struct AssociateStructTest: AssociateProtocol {
    // 给关联类型关联真正的类型
    typealias Element = String
    
    func method1(element: String) {
        
    }
}

//MARK: - 访问权限
/*需要开放的内容访问权限⼤，需要封闭的内容访问权限窄
 1. open：具备最高的访问权限，其修饰的内容可以在任意的 中被访问和重写。
 2. public：仅次于open ，与open 的区别是public 修饰的内容可以在任意Module 中被访问，但不能被重写。
 3. internal：默认级别，只能允许在当前定义的Module 中访问和重写，不能被其他的Module 访问。
 4. fileprivate：修饰的内容只能在当前的源文件中使用。
 5. private：最严格的访问权限，修饰的内容只能在定义的作用域内使用，即使是同一个源文件中的其他作用域也不能访问。
 权限排序：open > public > internal > fileprivate > private
 
 通过在属性前面添加 private(set) 或 internal(set)可以让 set 方法的访问级别变成private 或internal ，这种方式常用于限制外界对内部
 属性的修改
 */


//MARK: - 值类型 引用类型
/*
 值类型
 值类型是一种当它被赋值给一个常量或者变量，或者被传递给函数时会被 拷⻉ 的类型。//并非指向同一东西，而是复制一份 制作的分身
 Swift 中的结构体（包括枚举）是值类型，所以它在赋值或者传递时总是会被拷贝。
 
 引用类型
 不同于值类型，引用类型被赋值到一个常量或者变量，或者被传递到一个函数时它不会被拷贝，而是指向同一个实例对象。
 内部使用引用计数器管理内存（ARC）。
 */

//MARK: - 结构体
/*
 结构体是由一系列具有相同类型或不同类型的数据和行为构成的数据集合。
 结构体中既可以定义属性又可以定义方法。
 结构体是值类型。
 使用 struct关键字定义结构体
 
 !!!!!!!
 Swift 中的所有的内建类型如 Int，Double，Bool 都是用结构体来实现的。
 Swift 中的 String，Array ，Set 和 Dictionary 也都是用结构体来实现的。
 这意味着它们都是值类型，所以它们在赋值或者传递时，会进行拷贝
 
 但OC中的NSString NSArray NSDictionary他们是作为类来实现的，所以他们的实例总是作为引用而不是拷贝来赋值和传递
 !!!!!!!
 
 面向协议，数据类型少量简单，不需要继承，以复制方式传递时优先考虑用结构体
 */
struct Student  {
    var name = "zhangsan"
    var age = 18
    var sex = "男"
    
    //MARK: 存储属性
    /*存储属性  最先被初始化
     结构体与类可以定义存储属性，枚举不可以定义存储属性。
     可以提供默认值，也可以在构造函数中进行初始化
     可以是var 或者let 。
     存储在实例对象的内存中
     */
    var address:String?//可以提供默认值，也可以在构造函数中进行初始化 /不给存储属性赋值时必须是可选型
    
    //MARK: 计算属性
    /*计算属性
     枚举、结构体和类都可以定义计算属性
     必须是var ，不能是let 。
     不直接存储值，但需要提供一个get 和一个[可选]的set 方法间接计算而来。
     通过get 方法获取值，set 方法设置值，且在set 方法中默认提供一个名为newValue的变量表示传进来的设置值。
     如果只提供get ，而不提供 set，则该计算属性为只读属性，此时可以省略get{} 。
     */
    
    var chineseScore: Double = 0.0
    var mathScore: Double = 0.0
    var averageScore: Double {
         get {
             (chineseScore + mathScore) / 2
         }
         // set中如果执⾏self.averageScore = newValue会发⽣死循环，因为在set内部进⾏赋值⼜会调⽤set⽅法
         // 可以采⽤赋值给另外⼀个属性来防⽌死循环
         // newValue是系统分配的变量名，内部存储着新值
         set {
             //self.averageScore=newValue //会发⽣死循环，因为在set内部进⾏赋值⼜会调⽤set⽅法
             mathScore = newValue * 2 - chineseScore
         }
    }
    //MARK: 只读属性
    var totalScore:Double{
        chineseScore+mathScore
    }
    
    //MARK: 类属性
    /*类属性   与类想关联，而不是与类的实例对象相关联
     属性的设置和修改，需要通过类型而不是对象来完成。
     类型属性使用 static 来修饰。
     枚举、结构体、类都可以定义类型属性。
     */
    static var courseCount: Int = 5
    
    //MARK: 懒加载
    /*懒加载
     必须是var ，不能是let
     只在第一次访问时初始化一次，但如果有多条线程同时第一次访问，无法保证属性只被初始化一次。
     本质：在第一次访问的时候执行闭包，将闭包的返回值赋值给属性
     无法用于计算属性
     格式:  lazy var 变量: 类型 = { 创建变量代码 }()
     */
    lazy var rank:String = {
        return "排名第一"
    }()
    
    //MARK: 属性观察器 监听属性变化
    /*属性观察器
     Swift 通过属性观察器来监听和响应属性值的变化。
     可以为 var 修饰的存储属性、lazy 属性和类型属性的设置属性观察器。
     对于计算属性，不需要定义属性观察器，因为计算属性在set 里就可以获取到属性的变化
     定义：
      willSet 在属性值被存储之前设置。此时新属性值作为一个常量参数被传入，该参数默认名为newValue ，可以自定义。
      didSet 在新属性值被存储后立即调用。此时传入的是属性的旧值，该参数默认名为oldValue ，可以自定义。
      willSet与didSet 只有在属性改变时才会调用，在构造函数中进行初始化时不会调用。
     */
    // 存储属性 这⾥⽤可选型，否则需要⽤构造函数初始化
    var favor:String? {
        // 属性即将改变，还未改变时会调⽤的⽅法
         // 可以给newValue⾃定义名称  willSet(new)
        willSet{
            DPrint("值即将改变")
            if let newValue = newValue {// 在该⽅法中有⼀个默认的系统属性newValue，⽤于存储新值
                DPrint("new\(newValue)")
            }
        }
        // 属性值已经改变了，会调⽤的⽅法
        didSet{
            DPrint("值已经改变")
            if let oldValue = oldValue {// 在该⽅法中有⼀个默认的系统属性oldValue，⽤于存储旧值 oldValue需要在整个set动作之前进⾏获取并存储待⽤，所以存在get操作
                DPrint("old\(oldValue)")
            }
        }
    }
    
    static var grade:Int?{
        willSet{
            DPrint(newValue ?? 0)
        }didSet{
            DPrint(oldValue ?? 0)
        }
    }
    
    //mutating实例方法
    var word = "Object-C"
    //值类型(结构体)默认情况下，不能在实例方法中修改属性的值。如果需要修改，可以在函数前加上 mutating 关键字来实现
    mutating func say() {
        DPrint("学生说话")
        self.word="swift"
    }
}

//MARK: 全局属性
//全局属性：类型外面的属性，作用域全局
let studentCount : Int = 10


//MARK: - 类
/*
 Swift 虽然推荐面向协议编程（POP），但其也是一门面向对象编程语言（OOP）。
 面向对象的基础是类，类产生了对象（类的实例）。
 类也是由一系列具有相同类型或不同类型的数据和行为为构成的数据集合。
 类中既可以定义属性又可以定义方法。
 类是引用类型。
 使用class 关键字定义类
 */
class Person {
    var name = "zhangsan"
    var age = 18
    final var sex = "男"//防止重写
    var address:String?//可以提供默认值，也可以在构造函数中进行初始化 /不给存储属性赋值时必须是可选型
    
    //实例方法
    func say() {
        DPrint("说话")
    }
    
    //MARK: 类方法
    /* 通过类型而不是对象来调用的方法  static修饰的方法叫做静态方法， class修饰的叫做类方法
     在函数前加上 static 关键字，能在类和结构体中使用
     在函数前加上 class 关键字，只能在类中使用。
     
     1. class不能修饰存储属性， static可以修饰存储属性， static修饰的存储属性称为静态变量（常量）。
     2. class修饰的计算属性可以被重写， static修饰的不能被重写。
     3. class修饰的类方法可以被重写， static修饰的静态方法不能被重写。
     4. class修饰的类方法被重写时，可以使用 static让方法变为静态方法。
     5. class修饰的计算属性被重写时，可以使用static 让其变为静态属性，但它的子类就不能被重写了。
     6. class只能在类中使用，但是 static可以在类，结构体，或者枚举中使用
     */
    //class func study()
    static func study() {
        DPrint("学习")
    }
}

/*
 一个类可以从另一个类继承方法、属性和其他的特性。//结构体不可继承  但二者都可以被扩展，遵循协议
 当两个类形成继承关系，继承的类就是子类，被继承的就是父类。
 继承的目的是为了代码复用（Do Not Repeat Yourself）
 
 
 重写指的是子类可以对继承自父类的属性和方法进行自己的实现，从而达到与父类不一样的数据和行为。
 重写的属性和方法前需要加上override 关键字。
 override关键字执行时 Swift 编译器会检查重写的类的父类（或者父类的父类）是否存在匹配的属性与方法，如果没有会报错
 
 可以通过 final 标记 class、func、let/var 阻止子类的重写
 
 
 多态指的是同一操作作用于不同的对象，可以产生不同的执行结果
 */
class PersonRide: Person {//类的覆写
    //重写属性
    override var age: Int{
        get{
            19
        }set{
            
        }
    }
    //覆写方法
    override func say() {
        DPrint("不说话")
    }
}

//MARK: - 构造与析构函数(初始化与反初始化)
/*
 枚举、结构体、类都可以有构造函数，但只有类有析构函数
 
 构造函数不需要手动调用，默认情况下创建实例时，必然会调用构造函数。
 构造函数的名字为关键字init ，且没有func 修饰。
 如果类是继承自NSObject ，可以对父类的构造函数进行重写
 */
class Human {
    /*
     结构体中的属性可以没有默认值，也不需要在构造函数中初始化。
     类中的属性必须满足 3 种情况之一，否则报错。
        有默认值。
        可选型。
        在构造函数中初始化。
     */
    var name: String
    var age: Int
    var sex: String
    
    //类的指定构造函数
    init() {
     DPrint("被调⽤")
     name = "Zhangsan"
     age = 10
     sex = "male"
    }
    
    //便捷构造函数必须从相同的类里调用另一个构造函数 最终必须调用一个指定构造函数
    
    // ⾃定义构造函数
    init(name: String, age: Int, sex: String){
        self.name = name
        self.age = age
        self.sex = sex
    }
    
    //析构函数
    deinit {
        //当引用计数为 0 时，系统会自动调用析构函数（不可以手动调用）
        //通常在析构函数中释放一些资源（如移除通知等操作）
    }
}
//MARK: 类类型的构造函数委托
class Car {
     var speed: Double
     // 指定构造函数
     init(speed: Double) {
         self.speed = speed
     }
    
    /*可失败的构造函数
      var species: String
      init?(species: String) {
          // 返回⼀个nil
          if species.isEmpty { return nil }
          self.species = species
      }
     */
     // 便捷构造函数
     convenience init() {
         self.init(speed: 60.0)
     }
}
class Bus: Car {
     var wheels: Int
     // 注意构造函数中赋值的顺序
     init(wheels: Int) {
         // 1. 给当前类的存储属性赋值
         self.wheels = wheels
         // 2. 调⽤super.init()
         // 由于⼦类继承了⽗类中的存储属性 所以必须借助⽗类的指定构造函数来初始化继承的那个存储属性的值
         // ⼀定要在⼦类的属性初始化完毕以后调⽤
         super.init(speed: 120.0)
         // 3. 给继承的属性赋值
         speed = 10
     }
     convenience init() {
         self.init(wheels: 6)
     }
}

//MARK: - 单例
class SharedManager {
     // 类型属性
     static let shared = SharedManager()
     // 关键点：私有构造函数，这样就⽆法通过init实例化
     private init() { }
}

/*
 // 使⽤单例
 let manager = SharedManager.shared
 */


//MARK: - 协议
/*
 协议为方法，属性以及其他特定的任务需求定义一个大致的框架。可被【类，结构体，或枚举类型】采纳以提供所需功能的具体实现
 协议是定义一些规范（属性、方法），之所以称之为规范，是因为属性和方法都没有具体的实现。
 由类、结构体或者枚举遵守并实现这些规范，这一过程被称为遵守（实现）协议
 protocol SomeProtocol {
  // 声明属性规范
  // 声明⽅法规范
 }
 
 必须为 var。
 必须设置类型。
 不可以有默认值。
 类型后面必须跟上{ get } 或者{ get set } 且 get与set 之间没有逗号
 方法不能有方法体，方法的参数不可以有默认值
  
 协议之间是可以相互继承的，最终遵守协议的类型需要实现所有协议中的方法
 */

protocol PetProtocol {
    // 属性
    var name: String { get set }
    var age: Int { get }
    
    // ⽅法
    func feed(food: String)
    mutating func shout(sound: String)
}

//协议中的方法可选
@objc protocol PetProtocolOpt {
    // 该⽅法可选
    @objc optional func optionalFunc()
    func sleep()
}
extension PetProtocol {
    func feed(food: String) {
        DPrint("喂食：\(food)")
    }
}

//协议与协议组合：可以利用 组合多个协议。
//typealias ReadAndWriteProtocol = PetProtocol & PetProtocolOpt

//实现
struct Pet: PetProtocol {
    /*
     默认情况下，协议中的所有属性必须实现。
     此时属性可以设置默认值。
     协议中属性为可读可写的，可以直接声明为var 类型。
     协议中属性为可读属性，可以直接声明为let 类型，也可以声明为var 类型。
     */
    var name: String
    var age: Int
    
    /*
     默认情况下，协议中的所有方法必须实现。
     可以为方法中的参数设置默认值。
     在结构体中，如果需要改变属性的值，需要在方法前面加mutating 关键字。在协议的方法前添加 mutating关键字，如果结构体来遵守协议，需要有 mutating这个关键字，如果是类来遵守协议， mutating关键字就不需要了。
     正是由于协议同时适用于 class 、struct 和 enum，因此在定义协议时需要多考虑是否使用 mutating 来修饰方法。
     */
    func feed(food: String) {
        
    }
    
    mutating func shout(sound: String) {
        DPrint("喊叫")
    }
}

//MARK: - 代理模式
protocol ProtocolValueTransmit {
    func valueTransmit(value:String)
}

class DeliveryClass {
    // 声明代理
    var delegate : ProtocolValueTransmit?
    
    //事件点击或者外包主动调用
    func DeliveryValueTransmit() {
        delegate?.valueTransmit(value: "需要传递的值")
    }
}

class ReceicerClass: ProtocolValueTransmit {
    init() {
        let delivery=DeliveryClass()
        delivery.delegate=self
        delivery.DeliveryValueTransmit()
    }
    
    func valueTransmit(value: String) {
        DPrint("接受到的值：\(value)")
    }
}
//MARK: - 拓展
/*
 可以给现有的类、结构体、枚举类型、协议添加新的功能。
 扩展可以：
    添加计算属性。
    添加构造函数。
    添加方法。
    使现有的类型遵守协议。
 */

extension Collection {
    // 超出索引返回nil
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension Double {
    var km: Double { self * 1000.0 }
    var m: Double { self }
    var cm: Double { self / 100.0 }
    var mm: Double { self / 1000.0 }
}

extension CGRect {
    init(center: CGPoint, size: CGSize) {
        let originX = center.x - size.width * 0.5
        let originY = center.y - size.height * 0.5
        self.init(x: originX, y: originY, width: size.width, height: size.height)
    }
}

//MARK: - 面向协议编程POP
/*
 针对某个需要实现的功能，可以使用协议定义出接口，然后利用协议扩展提供默认的实现。需要这个功能，只需要声明遵守了这个协议即可，遵守某个协议的对象调用协议声明的方法时，如果遵守者本身没有提供实现，协议扩展提供的默认实现会被调用。
 
 假如有类继承关系如下：B、C 继承自 A，B1、B2 继承自 B，C1、C2 继承自 C。如果 B1 和 C2 具有某些共同特性，可以有 2 种做法：
 1. 找到 B1 和 C2 的最近祖先 A，然后在 A 中添加共同特性代码，这样做的结果是 A 的代码会越来越庞大臃肿，维护起来非常困难。
 2. 声明一个具有共同特性的协议，让 B1 和 C2 遵守该协议，这样其实等于相同的代码写了两次，造成代码的重复。
 3. 使用协议扩展，它能够为协议中规定的方法提供默认实现。因此声明一个具有共同特性的协议，扩展该协议给出共同特性的实现，然后让 B1 和 C2遵守该协议，既不影响类的继承结构，也不需要写重复代码。
 */
protocol LoginProtocolExample {
    func loginDispose()
}

extension LoginProtocolExample {
    func loginDispose() {
        DPrint("登录失败情况下默认操作")
    }
}

class LoginVCExample: LoginProtocolExample{
    func loginClick() {
        let bool : Bool = false
        if bool {
            loginDispose()
        }
    }
    func loginDispose() {
        DPrint("登录成功后进行的操作，不在实现拓展中默认操作")
    }
}



//MARK: - KVO
/*
 Apple 提供的一套事件通知机制，允许一个对象（观察者）监听另一个对象（被观察者）特定属性的改变，并在改变时接收到通知。
 KVO只对属性才会起作用。
 要使用 KVO，被观察者和观察者的类都需要继承自NSObject ，其中被观察者中的被观察属性需要用 @objc dynamic 修饰，观察者中的被观察者需
 要用 @objc 修饰。
 Swift 4 为KVO 增加了闭包的 API，简洁好用。观察者NSKeyValueObservation 虽然被对象持有，但其生命周期随着持有对象的释放而结束，不需
 要手动移除，因此不用担心忘记移除而导致程序崩溃
 */
// 被观察者 必须继承⾃NSObject
class Observed: NSObject {
    // 要观察的对象的属性必须⽤ @objc dynamic同时修饰
    @objc dynamic var age = 0
}
// 观察者 必须继承⾃NSObject
class Observer: NSObject {
    // 属性必须为 @objc
    @objc var q = Observed()
    // KVO的O
    var ob: NSKeyValueObservation?
    override init() {
        super.init()
        // Swift 4
        ob = observe(\.q.age, options: .new, changeHandler: { observe, change in
            print(observe.q.age) // 10
            print(change.newValue as Any) // Optional(10)
        })
    }
}

//let observer = Observer()
//observer.q.age = 10

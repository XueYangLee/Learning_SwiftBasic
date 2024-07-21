//
//  FunctionViewController.swift
//  BaseTools_Swift
//
//  Created by 李雪阳 on 2024/2/26.
//

import UIKit

class FunctionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        functionGram()
    }
    
    func functionGram() {
        //MARK: - 倍数判断
        let number = 4
        // 检查⼀个整数是否为另⼀个整数的倍数
        if number.isMultiple(of: 2) {
            print("偶数")
        } else {
            print("奇数")
        }
        
        //MARK: - random — 随机数
        // 随机数⽣成
        let ranInt = Int.random(in: 0 ..< 5)
        let ranFloat = Float.random(in: 0 ..< 5)
        let ranDouble = Double.random(in: 0 ..< 5)
        let ranBOOL = Bool.random()
        
        //MARK: - randomElement — 随机元素
        var array: [String] = ["Animal", "Baby", "Apple", "Google", "Aunt"]
        // 随机取得数组中的⼀个元素
        let element = array.randomElement()
        print(element!)
        // 随机数组
        var names = ["ZhangSan", "LiSi", "WangWu"]
        // 对数组元素进⾏重新随机排序，重新返回⼀个数组
        let shuffled = names.shuffled()
        
        
        //MARK: - toggle — 布尔切换
        var isSwift = true
        // toggle函数没有返回值
        isSwift.toggle()
        print(isSwift) // false
        isSwift.toggle()
        print(isSwift) // true
        
        
        //MARK: - UUID — 唯一识别码
        // Swift获取UUID很简单
        let uuid = UUID().uuidString
        print(uuid) // 类似 F1559B67-C89B-47E9-9C31-5D9366588552
    }
    
    
    
    func closureFunction() {
        var array: [String] = ["Animal", "Baby", "Apple", "Google", "Aunt"]
        
        //MARK: - sort — 排序
        
        // 这种默认是升序
        array.sorted()
        array.sort()
        
        //sorted：返回一个新的集合。
        array.sort { (str1: String, str2: String) -> Bool in//尾随闭包 省略return
          str1 > str2//G B Au Ap An
        }
        
        //sort：返回 Void，直接在原来的集合上操作
        array.sorted { (str1: String, str2: String) -> Bool in
          str1 > str2
        }
        // 简写
        // array.sort {$0 > $1}
        // array.sorted {$0 > $1}
        
        //MARK: - forEach — 遍历
        array.forEach { str in
            //遍历闭包形式写法，等同 for i in array 写法
        }
        // 简写
        // array.forEach { print($0)}
        
        //MARK: - filter — 筛选
        //filter默认返回为Bool值
        let filterArray = array.filter { str in
            str.starts(with: "A")//判断元素是否以A打头
        }//结果为Au Ap An
        //简写
        //array.filter { $0.starts(with: "A")}
        
        //MARK: - first(where:) — 筛选第一个符合条件
        let firstEle = array.first { str in
            str.hasPrefix("A")
        }
        
        //MARK: - last(where:) — 筛选最后一个符合条件
        let lastEle = array.last { $0.hasPrefix("A")}
        
        //MARK: - removeAll(where:) — 条件删除
        //高效根据条件删除，比filter内存效率高，指定不想要的东西，而不是想要的东西
        array.removeAll { $0.hasPrefix("S")}
        
        
        //MARK: - allSatisfy — 条件符合
        // 检查序列中的所有元素是否满⾜条件，全部满⾜条件才返回 true
        let satisfyEle = array.allSatisfy { str in
            str.hasPrefix("A")
        }//bool返回
        
        //MARK: - map — 转换
        // 闭包返回⼀个变换后的元素，接着将所有这些变换后的元素组成⼀个新的数组
        let mapArray = array.map { str in
            "Hello"+str
        }//结果则是所有数组元素钱都加Hello
        
        // 简写
        // array.map{ "Hello " + $0 }
        
        //MARK: - compactMap — 压缩转换
        //返回操作的新数组（并不是筛选）,字符串、数组、字典都可以使⽤  它的作⽤是将map结果中那些nil的元素去除掉，该操作可能会 “压缩” 结果，减少元素，因此得名compact
        let compactArray: [String] = ["1", "2", "3", "cat", "5"]
        let compact = compactArray.compactMap { str in
            Int(str)
        }
        
        //MARK: - mapValues — 转换value 只能用于字典
        let dic: [String: Int] = [
         "first": 1,
         "second": 2,
         "three": 3,
         "four": 4,
        ]
        // 字典中的函数, 对字典的value值执⾏操作, 返回改变value后的新的字典
        let mapValues = dic.mapValues { value in
            value+10
            //"Hello \(value)" 转成字符串
        }
        //let mapValues = dic.mapValues { $0 + 2 }
        
        //MARK: - compactMapValues
        let compactDic: [String: String] = [
         "first": "1",
         "second": "2",
         "three": "3",
         "four": "4",
         "five": "abc",
        ]
        // 返回⼀个对value操作后的新字典， 并且⾃动过滤不符合条件的键值对
        let newDic = compactDic.compactMapValues { Int($0) }
        
        //MARK: - reduce — 合归
        
        var sum: [Int] = [11, 22, 33, 44]
        // reduce可以把多个元素的值合并成⼀个新的值
        // reduce函数第⼀个参数是返回值的初始化值 partialResult是中间结果，num是遍历集合时每次传进来的值
        //sum.reduce(<#T##initialResult: Result##Result#>, <#T##nextPartialResult: (Result, Int) throws -> Result##(Result, Int) throws -> Result##(_ partialResult: Result, Int) throws -> Result#>)
        let total = sum.reduce(0) { partialResult, num in
            partialResult + num
        }//total=110
        
    }

}





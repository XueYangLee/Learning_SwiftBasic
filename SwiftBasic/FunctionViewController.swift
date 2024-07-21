//
//  FunctionViewController.swift
//  BaseTools_Swift
//
//  Created by 李雪阳 on 2024/2/26.
//

import UIKit
import Combine

class FunctionViewController: UIViewController {

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
    
    
    
    func combineOperateFunction() {
        //MARK: - collect
        ["A", "B", "C", "D", "E"].publisher.collect(2).sink(receiveCompletion: {
            print($0)
        }, receiveValue: {
            print($0)
        })
        /*输出
        ["A", "B"]
        ["C", "D"]
        ["E"]
        finished
        */
        
        //MARK: - scan
        /*
         第一个参数是初始值。
         第二参数是尾随闭包，接受两个参数：
         参数1：闭包最后一次返回的值。
         参数2：Publisher 当前发出的值
         */
        // 对序列进⾏累加，并输出每次的值
        [1, 2, 3, 4, 5].publisher.scan(0) { $0 + $1}.sink(receiveValue: {
            print($0)
        })//1 3 6 10 15
        
        //MARK: - flatMap
        //将多个 Publisher 扁平化为一个 Publisher。   案例：顺序执行多个网络请求
        let flatSubscription = URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.example1.com")!)
            .flatMap { data, response in
                URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.example2.com")!)
            }
            .flatMap { data, response in
                URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.example3.com")!)
            }
            .sink(receiveCompletion: {_ in print("receiveCompletion") },
                  receiveValue: { value in })
        
        
        //MARK: - filter
        (1...10).publisher
         .filter { $0.isMultiple(of: 3) }
         .sink(receiveValue: { print($0) })//3 6 9
        
        //MARK: - replaceNil
        //将 Publisher 中的 的值替换成指定的值
        ["A", nil, "C"].publisher
         .replaceNil(with: "*_*")
         .map { $0! }
         .sink(receiveValue: { print($0) })
        /*输出
        A
        *_*
        C
        */
        
        
        //MARK: - removeDuplicates
        //过滤掉连续重复的数据
        let userInput = ["aaa", "aaa", "bbbb", "ccc", "bbbb"].publisher
        let removeSubscription = userInput
            .removeDuplicates()
            .sink(receiveValue: { print($0) })
         
        /* 输出
        aaa
        bbbb
        ccc
        bbbb
        */
        
        
        //MARK: - ignoreOutput
        //如果只想知道 Publisher 什么时候结束，但不关心它发出的数据，可以使用 ignoreOutput
        (1...10).publisher
            .ignoreOutput()
            .sink(receiveCompletion: {
                print("Completed with: \($0)")
            },receiveValue: {
                print($0)
            })
        /* 输出
        Completed with: finished
        */
        
        
        
        //MARK: - reduce
        //用法和 scan 类似，只不过 reduce 会发出最后一次闭包的运算结果
        // Publisher将发布五个output值，当序列中值耗尽时，它将发布finished。⽽经过reduce变形后，新的Publisher只会在接到上游发出的finished事件后，才会将reduce后的结果发布出来
        [1, 2, 3, 4, 5].publisher
            .reduce(0) { $0 + $1}
            .sink(receiveValue: {
                print($0)
            })
        /* 输出
        15
        */
        
         
        //MARK: - min
        //找出 Publisher 所发出的全部数据中的最小值。
        (1...10).publisher
            .min()
            .sink(receiveValue: {
                print($0)
            })
        /* 输出
        1
        */
        
        
        //MARK: - first
        //找出 Publisher 的第一个数据，然后就马上结束，并取消对 Publisher 的订阅
        (5...10).publisher
            .first()
            .sink(receiveValue: {
                print($0)
            })
        /* 输出
        5
        */
        
        
        //MARK: - count
        //计算 Publisher 发出的所有数据的个数
        (1...10).publisher
            .count()
            .sink(receiveValue: {
                print($0)
            })
        /* 输出
         10
         */
        
        
        //MARK: - share
        /*
         将值类型的 Publisher 包装为引用类型。
         对于网络等资源密集型操作进行 share 可避免因大量不必要的请求导致的内存问题。
         案例：只执行一次网络请求的情况下想要多个 Subscriber 接收到数据
         */
        // 默认情况下dataTaskPublisher是struct
        let shared = URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.baidu.com")!).share() // 通过share()转成引⽤类型
        print("=====subscribing first=====")
        
        let shareSubscription1 = shared.sink(receiveCompletion: {
            print("subscription1 \($0)")
        }, receiveValue: {
            print("subscription1 received: '\($0)'")
        })
        print("=====subscribing second=====")
        
        let shareSubscription2 = shared.sink(receiveCompletion: {
            print("subscription2 \($0)")
        }, receiveValue: {
            print("subscription2 received: '\($0)'")
        })
        /* 输出
        =====subscribing first=====
        =====subscribing second=====
        subscription1 received: '(data: 2443 bytes...)'
        subscription2 received: '(data: 2443 bytes...)'
        subscription1 finished
        subscription2 finished
         
         第一次 调用触发了订阅。
         第二次 并没有触发什么，而 Publisher 继续执行。
         请求完成后，两个 Subscriber 都收到了数据
        */
        
        
        //MARK: - multicast
        
        /*
         share 存在的问题可以使用 multicast 解决。
         返回一个ConnectablePublisher 。在主动调用 connect()之前，它不会向上游 Publisher 发出订阅。
         必须提供一个 Subject类型的参数
         */
        var cancellables: Set<AnyCancellable> = []
        let multiSubject = PassthroughSubject<Data, URLError>()
        // 默认情况下dataTaskPublisher是struct
        let multicast = URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.baidu.com")!).map(\.data).multicast(subject: multiSubject)
        print("=====subscribing first=====")
        
        multicast.sink(receiveCompletion: {
            print("subscription1 \($0)")
        }, receiveValue: {
            print("subscription1 received: '\($0)'")
        }).store(in: &cancellables)
        print("=====subscribing second=====")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            multicast.sink(receiveCompletion: {
                print("subscription2 \($0)")
            }, receiveValue: {
                print("subscription2 received: '\($0)'")
            }).store(in: &cancellables)
            
            //重链接
            multicast.connect().store(in: &cancellables)
        })
        /*输出
        =====subscribing first=====
        =====subscribing second=====
        subscription1 received: '2443 bytes'
        subscription2 received: '2443 bytes'
        subscription1 finished
        subscription2 finished
        */
        
        //MARK: - zip
        //通过传入两个 Publisher（要求Failure类型一致），输出组合的 Publisher。当组合的每一个 Publisher 都产生数据的时候，才会取出 相同的数据数据合并成元组发送给 Subscriber。除此以外，还有 3 个参数和 4 个参数的 zip 用于更多 Publisher 的组合
        let zippublisher1 = PassthroughSubject<Int, Never>()
        let zippublisher2 = PassthroughSubject<String, Never>()
        let zipsubscription = zippublisher1.zip(zippublisher2).sink(receiveCompletion: { _ in 
            print("Completed") },receiveValue: { 
                print("P1: \($0), P2: \($1)")
            })
        zippublisher1.send(1)
        zippublisher1.send(2)
        
        zippublisher2.send("a")
        zippublisher2.send("b")
        
        zippublisher1.send(3)
        zippublisher2.send("c")
         
        zippublisher1.send(completion: .finished)
        zippublisher2.send(completion: .finished)
        /* 输出
        P1: 1, P2: a
        P1: 2, P2: b
        P1: 3, P2: c
        Completed
        */
         
        /* 应用：并行执行多个网络请求
         let combined = Publishers.Zip3(
          URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.example1.com")!),
          URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.example2.com")!),
          URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.example3.com")!)
         )
         let subscription = combined.sink(receiveCompletion: {_ in print("receiveCompletion") },
          receiveValue: { (value1, value2, value3) in })
         */
        
        
        //MARK: - combineLatest
        //当 Publisher1 发布数据或者 Publisher2 发布数据时，将两个数据合并，作为新的数据发布出去。不论是哪个 Publisher，只要发布了新的数据，combineLatest 就把最新的数据和另一个 Publisher 中的最新的数据合并。除此以外，还有 3 个参数和 4 个参数的 combineLatest 用于更多Publisher 的组合。
        
        /* 输出
         let zipsubscription = zippublisher1.combineLatest(zippublisher2).sink(receiveCompletion: { _ in
             print("Completed") },receiveValue: {
                 print("P1: \($0), P2: \($1)")
             })
         
        P1: 2, P2: a
        P1: 2, P2: b
        P1: 3, P2: b
        P1: 3, P2: c
        Completed
        */
        
        
        //MARK: - merge
        //传入两个 Publisher（要求Output和Failure类型一致），输出混合后的 Publisher。它会把两个 Publisher 发出的数据根据发出的时间顺序合并后发送给 Subscriber。除此以外，还有 3 ～ 8 个参数的 merge 用于更多 Publisher 的组合
        let mergepublisher1 = PassthroughSubject<Int, Never>()
        let mergepublisher2 = PassthroughSubject<Int, Never>()
        let mergeSubscription = mergepublisher1.merge(with: mergepublisher2).sink { print($0) }
        mergepublisher1.send(1)
        mergepublisher1.send(2)
        
        mergepublisher2.send(11)
        mergepublisher2.send(22)
        
        mergepublisher1.send(3)
        mergepublisher2.send(33)
        mergepublisher1.send(completion: .finished)
        mergepublisher2.send(completion: .finished)
        /* 输出
        1
        2
        11
        22
        3
        33
        */
        
        
        //MARK: - retry
        //在发生异常的情况下，重新向先前的 Publisher 发送给定次数的请求，当所有尝试都用尽之后才往数据流的下游传播异常，这种方式在网络开发中常用。
        let url = URL(string: "https://www.baidu.com")
         
        let retrySubscription = URLSession.shared.dataTaskPublisher(for: url!)
         .retry(3) // 尝试3次
         .sink(receiveCompletion: { print($0) },
         receiveValue: { value in print(value) })
        
        
        //MARK: - print
        
        let printSubscription = [1, 2, 3].publisher.print("debug info").sink { _ in }
         
        /* 输出
        debug info: receive subscription: ([1, 2, 3])
        debug info: request unlimited
        debug info: receive value: (1)
        debug info: receive value: (2)
        debug info: receive value: (3)
        debug info: receive finished
        */
        
        
        //MARK: - handleEvents
        
        let subscription = [1, 2, 3].publisher.handleEvents(receiveSubscription: { print("Receive subscription: \($0)") },
                                                            receiveOutput: {  print("Receive output: \($0)") },
                                                            receiveCompletion: { print("Receive completion: \($0)") },
                                                            receiveCancel: { print("Receive cancel") },
                                                            receiveRequest: { print("Receive request: \($0)") }).sink { _ in }
        /*输出
         Receive request: unlimited
         Receive subscription: [1, 2, 3]
         Receive output: 1
         Receive output: 2
         Receive output: 3
         Receive completion: finished
         */
        
        
        //MARK: - delay
        //延迟 Publisher 在某个 Scheduler 上数据的发送。
        let delaySubject = PassthroughSubject<String, Never>()
        let delaySubscription = delaySubject.delay(for: 3, scheduler: DispatchQueue.main).sink { data in
                print("delay:" + data)
            }
        // 输⼊Hello
        delaySubject.send("Hello")
        /* 3秒后输出
         delay:Hello
        */
        
        
        //MARK: - timeout
        //超时，如果上游 Publisher 超过指定的时间间隔而没有生成数据，则终止发布
        
        let timeoutsubject = PassthroughSubject<String, Never>()
        // delay时间超过timeout 不会有输出
        let timeoutSubscription = timeoutsubject
         .delay(for: 2, scheduler: DispatchQueue.main)
         .timeout(4, scheduler: RunLoop.main)
         .sink { data in
         print("timeout:" + data)
         }
        // 发送Hello
        timeoutsubject.send("Hello")
        /* 2秒后输出
         delay:Hello
        */
        
        
        //MARK: - debounce
        //翻译为 “防抖”，Publisher 在接收到第一个数据后，并不是立即将它发布出去，而是会开启一个内部计时器，当一定时间内没有新的数据来到，再将这个数据进行发布。如果在计时期间有新的数据，则重置计时器并重复上述等待过程。（时间间隔很重要）
        
        let debounceSubject = PassthroughSubject<String, Never>()
        // 主要理解1s的意思：它指的是当前Publisher发出的最后⼀个值的时间到当前时间间隔为1s时，并且Publisher还未结束，debounced才会发出Publisher当前的最后⼀个值。
        let debounceSubscription = debounceSubject
         .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
         .sink { data in
         print("debounce:" + data)
         }
        let debounceTypingHelloWorld: [(TimeInterval, String)] = [
         (0.0, "H"),
         (0.1, "He"),
         (0.2, "Hel"),
         (0.3, "Hell"),
         (0.4, "Hello"),
         (1.6, "HelloC"),
         (1.7, "HelloCo"),
         (2.8, "HelloCom"),
         (2.9, "HelloComb"),
         (3.0, "HelloCombi"),
         (3.1, "HelloCombin"),
         (3.2, "HelloCombine")
        ]
        //模拟输⼊：HelloCombine
        debounceTypingHelloWorld.forEach { (delay, str) in
            DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                debounceSubject.send(str)
            }
        }
        /* 输出
        debounce:Hello
        debounce:HelloCo
        debounce:HelloCombine
        */
        
        //MARK: - throttle
        //翻译为 “节流”，在固定时间内只发出一个数据，过滤掉其他数据，可以选择最后一个或第一个数据发出。它会在收到一个数据后开始计时，并忽略计时周期内的后续输入。（时间区间很重要）  例如 输入框等一句话完整输入完再执行操作
        
        let throttlesubject = PassthroughSubject<String, Never>()
        // 这⾥的1s指的是：throttled每隔1s就会发出最近的⼀个1s区间内Publisher发出的第⼀个值。
        // latest设置为false，意思是从每1秒的区间发出的值中取第⼀个值，如果是true就取最后⼀个值
        let throttlesubscription = throttlesubject
         .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: false)
         .sink { data in
         print("throttle:" + data)
         }
        
        let throttleTypingHelloWorld: [(TimeInterval, String)] = [
         (0.0, "H"),
         (0.1, "He"),
         (0.2, "Hel"),
         (0.3, "Hell"),
         (0.4, "Hello"),
         (1.0, "HelloC"),
         (1.2, "HelloCo"),
         (1.5, "HelloCom"),
         (2.0, "HelloComb"),
         (2.1, "HelloCombi"),
         (3.2, "HelloCombin"),
         (3.3, "HelloCombine")
        ]
        //模拟输⼊：HelloCombine
        throttleTypingHelloWorld.forEach { (delay, str) in
         DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
         throttlesubject.send(str)
         }
        }
        /* 输出
        throttle:H
        throttle:HelloC
        throttle:HelloComb
        throttle:HelloCombin
        */
    }

}





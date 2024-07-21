//
//  ConcurrencyPracticeViewController.swift
//  BaseTools_Swift
//
//  Created by 李雪阳 on 2024/2/29.
//

import UIKit

class ConcurrencyPracticeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
     
    /*concurrency 允许以类似同步的方式来编写包含异步代码的复杂逻辑
     回根据cpu核心数创建线程数量，无线程爆炸问题
     不需要线程切换，不同任务切换就是不同函数调用
     执行任务的线程不会阻塞
     使用concurrency不必关心线程的开辟跟管理问题
     
     结构化并发失职执行操作的任务之间，任务与其所处的上下文之间有一定结构关系
     非结构化并发失职从任意一个地方开始异步任务，在另外的地方对他进行其他操作
     async let 和 TaskGroup来处理机构化并发
     Task.init 和Task.detached来处理没有任何结构的非结构化并发
     */
    
    //MARK: GCD Example
    func GCDAsyncOperation(completionHandler: @escaping (String) -> Void) {
        
        DispatchQueue.global().async { // 开启新线程执⾏
            // 单个或多个异步操作
            print("before")
            let str = self.doSomething() // 线程执⾏到这⾥会阻塞直到doSomething返回，在这段时间线程将不能执⾏任何其他操作
            print("after")
            // 回调
            completionHandler(str)
        }
    }
    
    func doSomething() -> String {
        Thread.sleep(forTimeInterval: 3)
        return "async value"
    }
    
    func dispatchExample() {
        /*
         回调地狱：回调嵌套，代码可读性差。
         错误处理逻辑复杂：每个分支都有可能发生错误，需要回调错误，非常复杂。
         嵌套多层后，条件判断变得复杂，且容易出错。
         容易忘记回调或者回调后忘记返回
         */
        GCDAsyncOperation { value in
            DispatchQueue.main.async {
                print(value)
            }
        }
    }
    
    
    /*同步与异步函数
     默认情况下，所有函数都是同步函数，缺点就是执行时会阻塞。
     异步函数具有挂起的特殊能力，而同步函数没有（因此同步函数不能直接调用异步函数，因为不知道如何挂起自己）。
     一个挂起的函数不会阻塞它正在运行的线程，它会释放那个线程，被释放的线程就可以执行其他的任务。
     当异步函数从挂起状态恢复后可以继续从挂起的位置往后执行，但需要注意挂起之前和之后的代码可能运行在同一个线程，也可能在不同的线程，
     这取决于系统的调度。
     */
    
    //MARK: - async/await
    /*
     1. 使用 async 关键字标记的函数为异步函数，写在参数之后返回值之前，表示函数可挂起。
     2. 使用 await 关键字调用异步函数，写在异步函数调用之前，真正挂起异步函数。
     3. 异步函数内可以调用其他的异步函数，也可以调用同步函数，但同步函数不能调用异步函数。
     4. 异步函数的调用必须用await （使用async let 接收时不需要，后面会讲解）。
     5. 执行到await 时，会挂起异步函数并将控制权交给系统（执行任务的线程会被系统回收用于执行其他任务），当异步函数执行完毕后（异步函数恢复），系统会将控制权重新返还给调用者并从挂起的位置继续执行后续代码
     */
    
    // 定义异步函数
    func generateNum1() async -> Int {
        return 1
    }
    func generateNum2() async -> Int {
        if #available(iOS 13.0, *) {
            await Task.sleep(2 * 1000000000)
            print(#function, Thread.current)
        } else {
            // Fallback on earlier versions
        }
        return 2
    }
    func generateNum3() async -> Int {
        if #available(iOS 13.0, *) {
            await Task.sleep(3 * 1000000000)//纳秒单位
            print(#function, Thread.current)
        } else {
            // Fallback on earlier versions
        }
        return 3
    }
    
    //1. 通过异步函数
    func callAsync() async {
        // 异步执⾏，当前代码被挂起
        let x = await generateNum1()
        // 异步执⾏，当前代码被挂起 耗时2秒
        let y = await generateNum2()
        // 异步执⾏，当前代码被挂起 耗时3秒
        let z = await generateNum3()
        // 5秒以后才会计算
        let res = x + y + z
        print(res)
    }
    
    func asyncBasePractice() {
        //2. 通过 Task
        if #available(iOS 13.0, *) {
            // 1. Task.init中调⽤，因为同步函数⽆法调⽤异步函数，所以需要创建⼀个异步任务，后⾯同理
            Task {
                let one = await generateNum1()
                print(one, Thread.current)
            }
            // 2. Task.detached中调⽤
            Task.detached {
                let two = await self.generateNum2()
                print(two)
            }
            Task {
                await callAsync()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    //MARK: 异常处理
    /*
     抛出异常的语法：async throws 。
     处理异常的语法：try await 。
     */
    enum CustomAsyncError: Error {
        case negative
    }
    func callAsyncErrorFunc() async {
        // 异常处理
        do {
            try await generateErrorFunc(number: 1)
            try await generateErrorFunc(number: -1)
        } catch {
            print(error)
        }
    }
    // 定义时表示会有异常抛出
    func generateErrorFunc(number: Int) async throws {
        if number < 0 {
            // 抛出异常
            throw CustomAsyncError.negative
        } else {
            print(number)
        }
    }
    
    //MARK: - get async与async let
    //get async
    //除了方法可以异步，计算属性也可以异步，但只有只读属性支持 async
    class Person {
        let name: String = "zhangsan"
        var bmi: Double {
            get async {
                return await calBMI(weight: 80.0, height: 1.8)
            }
        }
        func calBMI(weight: Double, height: Double) async -> Double {
            weight / (height * height)
        }
    }
    
    func getAsyncPractice() {
        let p = Person()
        if #available(iOS 13.0, *) {
            Task {
                await p.bmi
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    //async let
    /*
     解决的是并发的另一个问题：并行。
     结构化并发的第 1 种形式，可以并行执行多个任务，即异步操作之间为并行执行。
     使用 async let 接收异步函数返回的结果，这样调用时可以省去await 。
     async let只能在异步函数或者 Task 中使用，不允许在顶层代码和同步函数中使用
     */
    //异步函数中调⽤
    func callAsyncLet() async {
        // 3个操作并⾏执⾏
        // 耗时1秒
        async let x = generateNum1()
        // 耗时2秒
        async let y = generateNum2()
        // 耗时3秒
        async let z = generateNum3()
        // 3秒以后就会计算
        let res = await x + y + z
        print(res)
    }
    
    
    //MARK: - Task
    /*
     单个任务使用 Task，多个任务使用 TaskGroup
     
     Task可以处于以下 3 种状态之一：运行、暂停或完成。
     Task 可以设置优先级： high medium low userInitiated utility background。
     常见属性与方法：
     value：获取当前 Task 的执行结果。
     priority：获取 Task 优先级。
     isCancelled：Task 是否取消。
     sleep()：休眠 Task，单位纳秒。与线程睡眠不同是它不会阻塞线程，休眠时该线程会被系统按需用作他用。
     cancel()：取消 Task。
     suspend()：挂起 Task。
     yield()：暂停 Task，当某个 Task 持续执行，可以调用它以释放机会给其他 Task 执行。但调用它并不意味着当前 Task 将停止运行，如果它比其他 Task 的优先级更高，那么调用之后有可能又立即执行
     
     Task.init 会继承调用者的优先级、任务本地值和 actor 上下文，而Task.detached 不会继承这些信息(比如在DispatchQueue.main.async主线程中调用，init就会继承在主线程中运行，而detach即使是在主线程中调用依旧会开辟新的线程)
     */
    
    func taskValue() async {
         // 构造Task并设置优先级
         // Task⼀旦创建就会⾃动执⾏，不需要调⽤任何⽅法
         // Task与其他代码并⾏运⾏
        if #available(iOS 13.0, *) {
            
            let userTask = Task(priority: .high) { () -> NewsModel in
                let url = URL(string: "http://v.juhe.cn/toutiao/index?type=top&key=d1287290b45a69656de361382bc56dcd")!
                // API必须iOS15以上
                let (data, _) = try await URLSession.shared.data(from: url)
                return try JSONDecoder().decode(NewsModel.self, from: data)
            }
            
            // 1. 通过value属性直接获取结果
            do {
                let newsModel = try await userTask.value
                print(newsModel.result.data.count)
            } catch {
            print(error.localizedDescription)
            }
            // 2. Task也提供了⼀个result属性（Result 类型）获取结果
            do {
                let result = await userTask.result
                let newsModel = try result.get()
                print(newsModel.result.data.count)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            // Fallback on earlier versions
        }
         
        
     }
    
    
    //MARK: - Task Local Value
    /*
     任务本地值，可以使用 TaskLocal 存储/设置某些数据，该数据会存储在 Task 的上下文中，Task 及其所有子 Task 都可以使用它。
     通过使用 @TaskLocal 修饰[静态变量]实现，即 @TaskLocal static var ，这样就可以在 Task 中读取该数据，并可以通过 DataType.$yourProperty.withValue(someValue) 的方式设置该数据
     
     // 枚举、结构体、类都可以
     enum LocalStorage {
      @TaskLocal static var name: String?
     }
     
     Task {
         LocalStorage.$name.withValue("TaskLocal"){
             print("task:", LocalStorage.name ?? "unknown")
         }
     }
     */
    
    //MARK: - TaskGroup
    /*
     这是并行的另一种解决方案。
     结构化并发的第 2 种形式，也可以并行执行多个任务。
     通过withTaskGroup() 或withThrowingTaskGroup() 方法创建。该方法的第一个参数指定最终生成的结果类型（如果没有任何输出可以
     写 Void.self ）。最后一个参数为闭包，需要在其中处理所有的任务，该闭包只有一个参数，类型为 TaskGroup<最终的结果类型>。
     常见属性与方法：
     isEmpty：TaskGroup 是否为空。
     isCancelled：TaskGroup 是否取消。
     cancelAll()：取消 TaskGroup 中所有的尚未执行的任务。
     addTask()：添加 Task 到 TaskGroup。
     next()：等待下一个 Task 执行完并返回 Task 返回的值。
     waitForAll()：等待所有 Task 完成后再返回。
     */
    
    func taskGroupPractice() async {
        // TaskGroup
        if #available(iOS 13.0, *) {
            await withTaskGroup(of: Int.self) { group in
                // 内部Task处理任务
                // 可以设置优先级
                // 3个操作并⾏执⾏
                group.addTask(priority: .medium) {
                    await self.generateNum1()
                }
                group.addTask {
                    await self.generateNum2()
                }
                group.addTask {
                    await self.generateNum3()
                }
                
                var sum: Int = 0
                // 计算，AsyncSequence
                // 按Task完成顺序处理结果
                // 由于异步for循环，在所有任务完成之前，闭包并不会返回
                // 3秒以后就会计算
                for await res in group {
                    sum += res
                }
                print(sum)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    /*
     1. async let适用于多个异步操作之间并无关联的情况，而TaskGroup 适合于异步操作之间关联较为紧密的情况。
     2. async let没有类似TaskGroup 的取消方法。
     3. async let无法像TaskGroup 可以存储以后进行传递。
     4. TaskGroup需要通过异步 for 循环进行任务结果的处理，而async let 不需要
     实际开发中，建议优先考虑使用async let 。
     */
    
}

//get async  协议
protocol SomeProcotol {
    var asyncProperty: Bool { get async }
    // 抛出异常
    var asyncThrowsProperty: String { get async throws }
}



//taskValue使用 新闻模型实例数据
struct NewsModel: Codable {
 var reason: String
 var error_code: Int
 var result: Result
}
struct Result: Codable {
 var stat: String
 var data: [DataItem]
}
struct DataItem: Codable {
 var title: String
 var date: String
 var category: String
 var author_name: String
 var url: String
}

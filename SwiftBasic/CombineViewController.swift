//
//  CombineViewController.swift
//  SwiftBasic
//
//  Created by 李雪阳 on 2024/3/12.
//

import UIKit
import Combine//导入框架

class CombineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //响应式编程（Reactive Programming）是面向异步数据流的编程思想。一个事件及其对应的数据被发布出来，最后被订阅者消化和使用。期间这些事件和数据需要通过一系列操作变形，成为我们最终需要的事件和数据。
    
    /*
     Combine 提供了一个声明式的 Swift API，可以用来处理开发中常见的Target/Action、Notification、KVO、callback/closure 以及各种异步网络请求
     Publisher（发布者）：负责发布数据。
     Subscriber（订阅者）：负责订阅数据。
     Operator（操作符）：负责在 Publisher和Subscriber 之间数据的转换
     Combine = Publishers + Subscribers + Operators
     */
    
    // MARK: - Publisher
    /*
     Publisher的主要工作是随着时间推移向一个或多个Subscriber 发布数据和事件。
     Publisher最主要的工作其实有两个：
         被Subscriber 订阅。
         发布数据和事件
     
     public protocol Publisher {
      /// 发布数据的类型
      associatedtype Output
      /// 失败的错误类型
      associatedtype Failure: Error
      /// Subscriber不会主动调⽤该⽅法，⽽是在调⽤subscribe()⽅法时内部会调⽤此⽅法
      func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input
     }
     extension Publisher {
      /// 将指定的Subscriber订阅到此Publisher
      /// 供外部调⽤，不直接使⽤receive(subscriber:)
      public func subscribe<S>(_ subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input
     }
     
     1. Output及Failure 定义了 Publisher 所发布的数据的类型和失败的错误类型。如果不会失败，则Failure 使用 。
     2. Publisher 只能发布一个结束事件，一旦发出了其生命周期就结束了，不能再发出任何数据和事件。
     3. Subscriber 调用 subscribe()方法订阅 Publisher 时会调用receive() 方法。 它规定：Publisher 的Output 必须与 Subscriber 的 类型匹配， Failure也是如此
     
     
     内置Publisher
     Just：只提供一个数据便终止的 Publisher ，失败类型为Never 。（★）
     Sequence：根据指定数据序列（数组、区间等）创建的 Publisher 。（★）
     Future：异步操作的 Publisher ，用一个闭包初始化。（★）
     Deferred：在运行提供的闭包之前等待订阅的 Publisher。（★）
     Share：它是一个类而非结构体 ，可以与多个 Subscriber 共享同一个 Publisher。
     Multicast：可以让多个 Subscriber 订阅同一个 Publisher 时产生相同的订阅效果。
     Empty： 一个不发布数据的 Publisher。
     Fail：由于指定 Error 而立即终止的 Publisher 。
     Record：允许记录一系列 Input和Completion ，供 Subscriber 订阅使用。
     Optional：如果可选型有值，则 Publisher 向 Subscriber 发布一次该可选数据，如果为 nil 则不发布任何数据。
     ObservableObject：与 SwiftUI 一起使用，符合ObservableObject 协议的对象即可作为 Publisher 。（★）
     @Published：属性包装器，用来将一个属性数据转变为 Publisher 。
     */
    
    // MARK: - Subscriber
    /*
     Publisher 根据Subscriber 的请求提供数据。如果没有任何订阅请求，Publisher 不会主动发布任何数据。所以可以这样说， Subscriber负责向Publisher 请求数据并接收数据（或失败）。
     
     public protocol Subscriber: CustomCombineIdentifierConvertible {
      /// 接收数据的类型
      associatedtype Input
      /// 可能接收到的失败的错误类型
      associatedtype Failure: Error
      /// 接收到订阅的消息，完成订阅可以开始请求数据了
      func receive(subscription: Subscription)
      /// 接收到产⽣的值的消息，Publisher发布了新的数据   //demand 背压机制  管理发布数据的最大值
      func receive(_ input: Self.Input) -> Subscribers.Demand
      /// 接收到产⽣已经终⽌的消息，Publisher发布了完成事件
      func receive(completion: Subscribers.Completion<Self.Failure>)
     }
     其中Input 和Failure 分别表示了 Subscriber 能够接收的数据类型和失败的错误类型。如果不会接收失败，则Failure 使用 Never。
     */
    
    
    func innerSubscriberPractice() {
        
        /*Sink
         在闭包中处理数据或 completion 事件。每当收到新值时，就会调用receiveValue 。还有一个可选的receiveCompletion ，当接收完所有的值之后调用。
         */
        // Just发送单个数据
        let publisher = Just(1)//同步行为
        
        let subscription = publisher.sink { _ in
            DPrint("receiveCompletion")
        } receiveValue: { value in
            DPrint(value) // 1
        }

        
        /*Assign
         将 Publisher 的 Output 数据设置到类中的属性。
         参数：某个类对象和该对象上的某个属性 KeyPath。
         应用：可以直接把发布的值绑定到数据模型或者 UI 控件的属性上。
         */
        let model = CombineModel()
        
        let publish = Just("zhangsan")
        publish.assign(to: \.name, on: model)
        DPrint(model.name)// zhangsan
        
         
        //自定义
        let customPub = [1, 2, 3, 4, 5, 6].publisher
        customPub.subscribe(CustomSubscriber())
        
    }
    
    
    //MARK: - Subscription
    /*
     流程：
     1. Subscriber 调用 Publisher 的subscribe(_ subscriber:) 方法开始订阅。
     2. Publisher 调用 Subscriber 的receive(subscription:) 发送确认信息给 Subscriber。该方法接收一个 Subscription。
     3. Subscriber 调用 2 中创建的 Subscription 上的request(_: Demand) 方法首次告诉 Publisher 需要的数据及其最大值。
     4. Publisher 调用 Subscriber 的receive(_: Input) 发送不超过第 3 步Demand 指定个数的数据给 Subscriber，并返回一个新的Demand ，告诉Publisher 下次发送的最大数据量。
     5. 同4
     6. Publisher 调用 Subscriber 的receive(completion :) 向 Subscriber 发送 completion 事件。这里的 completion 可以是正常 .finished ，也可以是.failure .failure的，如果是 的会携带一个错误信息。注意：如果中途取消了订阅，Publisher 将不发送完成事件。
     
     
     
     当 Publisher 发布新值时， Subscription负责协调 Publisher 和 Subscriber。在某种程度上可以说 Publisher 只负责发布数据，订阅流程的大部分工作是由 Subscriber 和 Subscription完成的
     
     public protocol Subscription: Cancellable, CustomCombineIdentifierConvertible {
      /// 告诉 Publisher 可以发送多少个数据到 Subscriber
      func request(_ demand: Subscribers.Demand)
     }
     
     1. Subscriber 调用 Publisher 的subscribe(_ subscriber:) 方法开始订阅。
     2. Publisher 会调用receive(subscriber:) ，在该方法中创建 Subscription 对象并调用 Subscriber 的receive(subscription:Subscription)方法传递给 Subscriber。
     3. Subscriber 调用 Subscription 的request(_ demand:) 方法首次告诉 Subscription 需要的数据及其最大值。
     4. Subscription 调用 Subscriber 的receive(_ input:) 方法发送数据给 Subscriber，并且返回一个Subscribers.Demand ，告诉 Subscription
     下次需要的最大数据量。
     5. 当最后一次值发布完毕，Subscription 会调用一次 Subscriber 的receive(completion:) 结束订阅流程。
     
     
     Subscribers.Demand常见的取值有  Demand.unlimited  Demand.none  Demand.max(Int)
      */
    
    //MARK: - Subject
    /*
     Subject是一种特殊的 Publisher，最大的特点是可以手动发送数据
     
     public protocol Subject: AnyObject, Publisher {
      func send(_ value: Self.Output)
      func send(completion: Subscribers.Completion<Self.Failure>)
      func send(subscription: Subscription)
     }
     */
    func subjectPractice()  {
        /*
         PassthroughSubject
         通过 send 发送数据或事件给下游的 Publisher 或 Subscriber， 并不会对接收到的数据进行保留
         */
        
        // 创建PassthroughSubject
        let subjectPass = PassthroughSubject<String, Never>()
        // 订阅
        let subscriptionPass = subjectPass.sink(receiveCompletion: { _ in
             print("receiveCompletion")
        }, receiveValue: { value in
             print(value)
        })
        
        // 发送数据
        subjectPass.send("Hello")
        // 中途取消   后续发送都会失败 Cancellable
        subscriptionPass.cancel()
        subjectPass.send("Combine")
        subjectPass.send(completion: .finished)
        
        /*
         CurrentValueSubject
         与PassthroughSubject不同的是它会保留一个最后的数据，并在被订阅时将这个数据发送给下游的 Publisher 或 Subscriber。
         CurrentValueSubject 初始化时需要提供一个当前值，并可以通过其 value 属性设置和获取当前值
         */
        
        // 创建CurrentValueSubject，需要初始化⼀个数据
        let subject = CurrentValueSubject<String, Never>("Hello")
        // 获取当前值
        print(subject.value)//hello
        // 发送数据
        subject.send("Combine")
        print(subject.value)
        
        // 发送数据
        subject.send("SwiftUI")
        print(subject.value)
        // 订阅
        let subscription = subject.sink { value in
            print(value)
        }
    }
    
    //MARK: - Cancellable
    /*
     在开发中，当 Subscriber 不想接收 Publisher 发布的数据时，可以取消订阅以释放资源。Combine 中提供了一个Cancellable 协议，该协议中定义了一个cancel() 方法，用于取消订阅流程。
     Combine 中还定义了一个 AnyCancellable类，它实现了 Cancellable 协议，特点是会在deinit 时自动执行cancel() 方法。
     sink和assign 的返回值都是AnyCancellable ，所以它们可以调用cancel() 方法来取消订阅
     
     !!当AnyCancellable 对象被释放后，整个订阅流程也会随之结束。所以在实际开发中需要把这个AnyCancellable 对象当做一个属性存储起来或者存储到Set<AnyCancellable> 中。(需要使用变量来接收  let subscription = subject。。。)
     */
    func cancelPractice() {
        //模拟网络原因导致的网络请求中断
        let dataPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.baidu.com")!)
        let cancellableSink = dataPublisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("received finished")
                    break
                    
                case .failure(let error):
                    print("received error: ", error) }
            }, receiveValue: { someValue in
                print("received \(someValue)")
            })
        
        // 可以取消
        cancellableSink.cancel()
    }
    
    //MARK: - Operator
    /*
     订阅某个 Publisher，Subscriber 中的 Input和Failure 要与 Publisher 的 Output和Failure 类型相同，但实际开发中往往是不同的，此时就需要借助Operator 进行转换。Operator 遵守 Publisher 协议，负责从数据流上游的 Publisher 订阅值，经过转换生成新的 Publisher发送给下游的 Subscriber
     */
    func operatorPractice() {
        let subscription = Just(520)
            .map { value -> String in
                return "I Love You"
            }.sink { receivedValue in
                print("最终的结果：\(receivedValue)")//输出"I Love You"
            }
        
        //MARK: Type Erasure
        /*
         Publisher 中的 Output 和 Failure 两个关联类型如果进行多次嵌套会让类型变得非常复杂，难以阅读，而实际开发中往往需要经过多次的操作才能得到合适的 Publisher。
         对于 Subscriber 来说，只需要关心 Publisher 的 Output 和 Failure 两个类型就能顺利订阅，它并不需要具体知道这个 Publisher 是如何得到、如何嵌套的。
         为了对复杂类型的 Publisher 进行类型擦除，Combine 提供了 eraseToAnyPublisher() 方法将复杂的 Publisher 转化为对应的通用类型AnyPublisher 。
         类型擦除后的 Publisher 变得简单明了易于理解，在实际开发中经常使用
         */
        // p1类型: Publishers.FlatMap<Publishers.Sequence<[Int], Never>, Publishers.Sequence<[[Int]], Never>>
        let p1 = [[1, 2, 3], [4, 5, 6]]
         .publisher
         .flatMap { $0.publisher }
        // p2类型: Publishers.Map<Publishers.FlatMap<Publishers.Sequence<[Int], Never>, Publishers.Sequence<[[Int]], Never>>, Int>
        let p2 = p1.map { $0 * 2 }
        // p3类型: AnyPublisher<Int, Never>
        let p3 = p2.eraseToAnyPublisher()
    }
    
    
    //MARK: - Publisher in Foundation 项目中常用publisher
    func publisherinFoundationPractice() {
        //Sequence Publisher  通过序列构造 Publisher，如数组，区间和字典等
        // 数组
        let sequencePub = ["a", "b", "c"].publisher // Combine.Publishers.Sequence<Array<String>, Never>
        // 区间
        (1...10).publisher // Combine.Publishers.Sequence<ClosedRange<Int>, Never>
        // stride
        stride(from: 0, to: 10, by: 2).publisher // Combine.Publishers.Sequence<StrideTo<Int>, Never> //跨级读取 打印 02468
        // 字典
        ["name" : "zhangsan", "age" : "15"].publisher // Combine.Publishers.Sequence<Dictionary<String, String>, Never>
        
        sequencePub.sink { value in
            DPrint(value )
        }
        
        //MARK: URLSession Publisher
        //可以更加简单的完成网络请求、数据转换等操作
        let url = URL(string: "https://www.baidu.com")
        // 创建Publisher
        let urlPublisher = URLSession.shared.dataTaskPublisher(for: url!)
        // 订阅
        let urlSubscripton = urlPublisher.sink(receiveCompletion: { print($0)
        }) { (data, response) in
         print(String(data: data, encoding: .utf8)!)
        }
         
        
        //MARK: Notification Publisher
        //系统通知
        let symSubscription = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification).sink(receiveValue: { _ in
            print("App进⼊后台")
        })
        //自定义
        var customNotiName = Notification.Name("customNotify")
        let customSubscription = NotificationCenter.default.publisher(for: customNotiName).sink { noti in
            DPrint(noti.object as? String)
        }
        // 创建通知
        let noti = Notification(name: customNotiName, object: "some info", userInfo: nil)
        // 发送通知
        NotificationCenter.default.post(noti)
        
        
        //KVO Publisher
        let kvoModel = CombineModel()
        let kvoSubscription = kvoModel.publisher(for: \.age).sink { newValue in
            print("person的age改成了\(newValue)")
        }
        kvoModel.age = 10 // 改变时会收到通知
        
        /*开发中常见的 KVO Publisher 操作：
         let scrollView = UIScrollView()
         scrollView.publisher(for: \.contentOffset)
         
         let avPlayer = AVPlayer()
         avPlayer.publisher(for: \.status)
         
         let operation = Operation()
         operation.publisher(for: \.queuePriority)
         */
        
        //MARK: Timer Publisher
        //遵守ConnectablePublisher 协议的 Publisher，它需要某种机制来启动数据流。 Timer Publisher就是这种类型的 Publisher。 ConnectablePublisher不同于普通的 Publisher，需要明确地对其调用 connect()或者 autoconnect()方法，它才会开始发送数据
        
        // every：间隔时间 on：在哪个线程 in：在哪个Runloop
        let autoConnectSubscription = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
            print("Hello")
        }
        //可取消
        // autoConnectSubscription.cancel()
        
        // every：间隔时间 on：在哪个线程 in：在哪个Runloop
        let timerPublisher = Timer.publish(every: 1, on: .main, in: .default)
         
        let cancellablePublisher = timerPublisher.sink { _ in
            print("World")
        }
        let connectSubscription = timerPublisher.connect()
        
        //MARK: @Published
        //属性包装（Property Wrapper），可以为任何一个属性生成其对应类型的 Publisher，这个 Publisher 会在属性值发生变化时发送消息。 @Published广泛应用于 UIKit 与 SwiftUI 中，用 @Published 修饰属性以后，通过 $属性名 即可得到该属性对应的 Publisher
        let publishedSubscription = kvoModel.$gender.sink {DPrint($0)}
        kvoModel.gender="女"
        
        /*
         // 定义Protocol，通过Published将实际类型包裹起来。
         protocol modelProtocol {
          var namePublisher: Published<String>.Publisher { get }
         }
         // 遵守协议，将name的值返回给namePublisher。
         class Student: modelProtocol {
          @Published var name: String
          
          var namePublisher: Published<String>.Publisher { $name }
          init(name: String) {
          self.name = name
          }
         }
         */
    }
    
    
    // MARK: - Scheduler
    /* 多线程切换的时候使用scheduler
     Scheduler在是一个协议，遵守了该协议的内置 Scheduler 有:
         DispatchQueue
         OperationQueue
         RunLoop
         ImmediateScheduler  立即执行同步操作， 如果使用它执行延迟的工作，会报错
     
     使用 RunLoop.main 、DispatchQueue.main 和 OperationQueue.main 来执行与 UI 相关的操作
     默认情况下，当前的 Scheduler 与最初产生数据的 Publisher 所在的 Scheduler 线程相同。但是实际情况往往是在整个数据流中需要切换 Scheduler，所以 Combine 提供了两个函数来设置 Scheduler
     */
    
    func schedulerPractice() {
        /*
         receive(on:)
         定义了在哪个 Scheduler 完成 Publisher 的订阅。（在哪里接收数据）
         */
        let receiveSubscription = Just(1)
            .map { _ in print(Thread.isMainThread) }
            .receive(on: DispatchQueue.global())
            .map { print(Thread.isMainThread) }
            .sink { print(Thread.isMainThread) }
        /* 输出
        true
        false
        false
        */
        
        
        /*
         subscribe(on:)
         定义了 Publisher 在哪个 Scheduler 来发布数据。（在哪里发布数据）
         */
        let subSubscription = Just(1)
            .subscribe(on: DispatchQueue.global())
            .map { _ in print(Thread.isMainThread) }
            .sink { print(Thread.isMainThread) }
        /* 输出
        false
        false
        */
        
        let subscription = URLSession.shared
            .dataTaskPublisher(for: URL(string: "https://www.baidu.com")!)//dataTaskPublisher网络请求会自己开辟个线程执行操作
            .map{ $0.data }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { print($0)
            }) { _ in
                print(Thread.isMainThread)
            }
        /* 输出
        true
        finished
        */
        
    }
    
    
    //MARK: - Future
    /*
     Just 等，那些 Publisher 其数据的发布和订阅是同步行为。但是如果希望数据的发布和订阅是异步的，需要使
     用Future 。 Future表示异步操作的最终完成或失败
     
     final public class Future<Output, Failure>: Publisher where Failure: Error {
      public typealias Promise = (Result<Output, Failure>) -> Void
      
      public init(_ attemptToFulfill: @escaping (@escaping Future<Output, Failure>.Promise) -> Void)
      
      final public func receive<S>(subscriber: S) where Output == S.Input, Failure == S.Failure, S : Subscriber
     }
     
     Future 是一个类，实现了 Publisher 协议。
     Future 会在初始化时立刻执行闭包，在该闭包里完成异步的操作。所以需要存储异步处理的结果，然后发送给一个或多个 Subscriber。
     无论有多少 Subscriber 订阅，Future 的异步操作只会执行一次，执行完就结束。
     */
    
    func futurePractice() {
        createFuture().sink(receiveCompletion: { comp in
            if case .failure(let error) = comp {
             // 失败的处理
                 print()
             }
        }, receiveValue: { value in
            print(value)//100
        })
        
        /*
         1. 当创建一个 Future 时，它会立即开始执行。
         2. Future 将只运行一次提供的闭包。
         3. 多次订阅同一个 Future 将返回同一个结果。
         */
    }
    
    // 返回⼀个Future对象且会产⽣⼀个Int类型的值
    func createFuture() -> Future<Int, Never> {
        // 返回⼀个Future，它是⼀个闭包
        // 在该闭包⾥执⾏异步操作，只会执⾏⼀次
        return Future { promise in
            // 异步操作
            // 最后必须调⽤promise完成⼯作
            promise(.success(100))
        }
    }
    
}

// MARK:  自定义Subscriber
// 1. 通过数组创建⼀个Publisher
//let publisher = [1, 2, 3, 4, 5, 6].publisher
// 7.订阅Publisher
//publisher.subscribe(CustomSubscriber())

// 2. ⾃定义⼀个Subscriber
class CustomSubscriber: Subscriber {
    // 3. 指定接收值的类型和失败类型
    typealias Input = Int
    typealias Failure = Never
    
    // 4. Publisher⾸先会调⽤该⽅法
    func receive(subscription: Subscription) {
        // 接收订阅的值的最⼤量，通过.max()设置最⼤值，还可以是.unlimited
        subscription.request(.max(6))
    }
    // 5. 接收到值时的⽅法，返回接收值的最⼤个数变化
    func receive(_ input: Int) -> Subscribers.Demand {
        // 输出接收到的值
        print("Received value", input)
        // 返回.none，意思就是不改变最⼤接收数量（永远为上⾯⽅法设置的⼤⼩，如果上⾯设置的最⼤值⼩于Publisher发送的数据，不会⾛completion），也可以通过.max()设置增⼤多少
        return .none
    }
    // 6. 实现接收到完成事件的⽅法
    func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion", completion)
    }
    
}


class CombineModel: NSObject {
    var name: String = ""
    //kvo publisher   kvo的类必须继承自NSObject  同时被监听的属性继承 @objc dynamic
    @objc dynamic var age: Int = 0
    //属性包装（Property Wrapper）
    @Published var gender: String = "男"
}

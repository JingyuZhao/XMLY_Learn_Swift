//
//  XMLYMeTestViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/13.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

import Security


class XMLYMeTestViewController: XMLYBaseViewController {

    let dispose = DisposeBag.init()
    
    var tickets : [Int] = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "RxSwift"
        self.view.backgroundColor = .blue
//        rxSwiftDemo()
    }

    override func configUI() {
        let leng : Int = findLastLengthSub(s: "dsjhaioweijdskaldsjhaiowe")
        print(leng)
        test()
    }
    
    
    
    func findLastLengthSub(s:String) -> Int {
       /*
        // 数组用于保存子串
        var list:[Character] = []
        // 用于保存最大子串的长度
        var m: Int = 0
        // 遍历字符串
        for sub in s {
            // 先获取最大的子串长度
            m = max(m, list.count) as Int
            // 如果子串中存在该字符，则删除数组中该字符之前的所有字符（包括该字符）
            if let index = list.firstIndex(of: sub)  {
                list.removeSubrange(Range.init(NSRange.init(location: 0, length: index + 1))!)
            }
            // 将字符添加到子串数组中
            list.append(sub)
        }
        return max(m, list.count) as Int*/
        
            var left = 0
            var right = 0
            var dic : [String : Int] = [:]
            let characters : [String] = s.map{String($0)}
            var lenths : [Int] = []
            for (index, value) in characters.enumerated() {
                   if dic.keys.contains(value) && left <= dic[value]! {
                         left = dic[value]! + 1
                    }
                    dic.updateValue(index, forKey: value)
                    right = index
                    lenths.append(right - left + 1)
                 }
            return lenths.max() ?? 0
    }
    
    func rxSwiftDemo() {
//        publishSubTestFun()
//        replaySubTestFun()
//        behaiverTestFun()
        variableTestFun()
    }

}
extension XMLYMeTestViewController{
    func test() {
        let que = DispatchQueue.init(label: "com.jk.thread", attributes: .concurrent)
        
        //生成100张票
        for i in 0..<100 {
            tickets.append(i)
        }
        
        for num in 0..<51 {
            //北京卖票窗口
            que.async {
                self.saleTicket()
            }
            print("*******************:\(num)")
            //GCD 栅栏方法，同步去库存
            que.async(flags: .barrier) {
                if self.tickets.count > 0 {
                    self.tickets.removeLast()
                }
            }
            
            print("##################:\(num)")
            //上海卖票窗口
            que.async {
                self.saleTicket()
            }
            
            //GCD 栅栏方法，同步去库存
            que.async(flags: .barrier) {
                if self.tickets.count > 0 {
                    self.tickets.removeLast()
                }
            }
            
        }
    }
  
    func saleTicket() {
        if tickets.count > 0 {
            print("剩余票数", tickets.count, "卖票窗口", Thread.current)
            Thread.sleep(forTimeInterval: 0.2)
        }
        else {
            print("票已经卖完了")
        }
    }
    
}
extension XMLYMeTestViewController{
    
    func variableTestFun() {
        
    }
    
    func behaiverTestFun() {
        let behavier = BehaviorSubject<String>.init(value: "3")
        //在首次订阅后，会打印初始值
        behavier.subscribe { (event) in
            print(event)
        }.disposed(by: dispose)
        
        behavier.onNext("hahh")
        //再次订阅后会打印上次最后一次的值
        behavier.subscribe { (event) in
            print(event)
        }.disposed(by: dispose)
        
        behavier.onNext("748327489")
    }
    
    func replaySubTestFun() {
        //replaySubject 可以接受订阅之前和之后的信号
        let replaySub = ReplaySubject<String>.create(bufferSize: 2)
        replaySub.onNext("1")
        replaySub.onNext("2")
        replaySub.onNext("3")
        //在订阅的时候，只会打印上次发送的bufferSize个元素
        replaySub.subscribe { (event:Event<String>) in
            print(event.element ?? "")
        }.disposed(by: dispose)
        replaySub.onNext("4")
        replaySub.onNext("5")

        replaySub.onNext("6")
        replaySub.subscribe { (event) in
             print(event.element ?? "")
        }.disposed(by: dispose)

        replaySub.onCompleted()
        
    }
    
    
    func publishSubTestFun(){
        //publishSubject只能接受订阅之后的信号
        let publishSub = PublishSubject<String>.init()
        publishSub.onNext("dsda")
        //订阅信号
        publishSub.subscribe { (event) in
            print(event)
        }.disposed(by: dispose)
        
        publishSub.subscribe(onNext: { (strin) in
            print(strin)
        }).disposed(by: dispose)
        //发送信号
        publishSub.onNext("Helloworld")
    }
}

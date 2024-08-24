//
//  ConcurrentSerialQueueViewModel.swift
//  DispatchAndOperationQueue
//
//  Created by  Prince Shrivastav on 24/08/24.
//

import Foundation

class ConcurrentSerialQueueViewModel {
    
    private let concurrentQueue = DispatchQueue(label: "com.concurrent.queue",qos: .default, attributes: .concurrent)
    
    func concurrentQueueExample() { // no order
        concurrentQueue.async {
            print("1")
            self.concurrentQueue.sync {
                print("2")
            }
        }
        concurrentQueue.async {
            print("3")
            self.concurrentQueue.sync {
                print("4")
            }
        }
        concurrentQueue.async {
            print("5")
            self.concurrentQueue.sync {
                print("6")
            }
        }
        concurrentQueue.async {
            print("7")
            self.concurrentQueue.sync {
                print("8")
            }
        }
    }
    func concurrentQueueExample2() { // no order
        concurrentQueue.async {
            print("1")
            self.concurrentQueue.sync {
                print("2")
            }
            print("9")
        }
        concurrentQueue.async {
            print("3")
            self.concurrentQueue.async {
                print("4")
            }
            print("10")
        }
        concurrentQueue.async {
            print("5")
            self.concurrentQueue.async {
                print("6")
            }
            print("11")
        }
        concurrentQueue.async {
            print("7")
            self.concurrentQueue.sync {
                print("8")
            }
        }
    }
    func concurrentQueueExample3() { // 1,2,3,4,5,6,7,8
        concurrentQueue.sync {
            print("1")
            self.concurrentQueue.sync {
                print("2")
            }
        }
        concurrentQueue.sync {
            print("3")
            self.concurrentQueue.sync {
                print("4")
            }
        }
        concurrentQueue.sync {
            print("5")
            self.concurrentQueue.sync {
                print("6")
            }
        }
        concurrentQueue.sync {
            print("7")
            self.concurrentQueue.sync {
                print("8")
            }
        }
    }
    func concurrentQueueExample4() { // 1,2,9,3,10, no order
        concurrentQueue.sync {
            print("1")
            self.concurrentQueue.sync {
                print("2")
            }
            print("9")
        }
        concurrentQueue.sync {
            print("3")
            self.concurrentQueue.async {
                print("4")
            }
            print("10")
        }
        concurrentQueue.sync {
            print("5")
            self.concurrentQueue.async {
                print("6")
            }
            print("11")
        }
        concurrentQueue.sync {
            print("7")
            self.concurrentQueue.sync {
                print("8")
            }
        }
    }
    
    let serialQueue = DispatchQueue(label: "com.serial.queue")
    
    func serialQueueExample() { // 1,3,5,7,2,4,5,8
        serialQueue.async {
            print("1")
            self.serialQueue.async {
                print("2")
            }
        }
        serialQueue.async {
            print("3")
            self.serialQueue.async {
                print("4")
            }
        }
        serialQueue.async {
            print("5")
            self.serialQueue.async {
                print("6")
            }
        }
        serialQueue.async {
            print("7")
            self.serialQueue.async {
                print("8")
            }
        }
    }
    func serialQueueExample2() { // 1,2,3,4,5,6,7,8
        serialQueue.sync {
            print("1")
            self.serialQueue.async {
                print("2")
            }
        }
        serialQueue.sync {
            print("3")
            self.serialQueue.async {
                print("4")
            }
        }
        serialQueue.sync {
            print("5")
            self.serialQueue.async {
                print("6")
            }
        }
        serialQueue.sync {
            print("7")
            self.serialQueue.async {
                print("8")
            }
        }
    }
    
    var accountBalance = 500
    
    private func debetMoneyFromAccount(amount: Int) {
        if accountBalance > amount {
            accountBalance -= amount
            print("\(amount) is debeted from your account now balance is \(accountBalance)")
        } else {
            print("!!Insufficient balance!! remaining balance\(accountBalance), trying to debet \(amount)")
        }
    }
    
    func debetMoneyConcurrently() {
        concurrentQueue.async {
            self.debetMoneyFromAccount(amount: 100)
        }
        concurrentQueue.async {
            self.debetMoneyFromAccount(amount: 500)
        }
        concurrentQueue.async {
            self.debetMoneyFromAccount(amount: 50)
        }
        concurrentQueue.async {
            self.debetMoneyFromAccount(amount: 200)
        }
    }
    
    func debetMoneyConcurrentlySync() {
        concurrentQueue.sync {
            self.debetMoneyFromAccount(amount: 100)
        }
        concurrentQueue.sync {
            self.debetMoneyFromAccount(amount: 500)
        }
        concurrentQueue.sync {
            self.debetMoneyFromAccount(amount: 50)
        }
        concurrentQueue.sync {
            self.debetMoneyFromAccount(amount: 200)
        }
    }
    
    func debetMoneySerial() {
        serialQueue.async {
            self.debetMoneyFromAccount(amount: 100)
        }
        serialQueue.async {
            self.debetMoneyFromAccount(amount: 500)
        }
        serialQueue.async {
            self.debetMoneyFromAccount(amount: 50)
        }
        serialQueue.async {
            self.debetMoneyFromAccount(amount: 200)
        }
    }
    
}

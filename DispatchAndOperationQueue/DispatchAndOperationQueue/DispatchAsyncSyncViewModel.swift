//
//  DispatchAsyncSyncViewModel.swift
//  DispatchAndOperationQueue
//
//  Created by  Prince Shrivastav on 24/08/24.
//

import Foundation

class DispatchAsyncSyncViewModel {    
    /*
     The code snippet you provided will crash because of a deadlock caused by calling DispatchQueue.main.sync from the main thread.

     Here's what happens:

     1. deadlock() is called from the main thread.
     2. print("1") is executed.
     3. DispatchQueue.main.sync is called, which blocks the main thread until the closure is executed.
     4. However, the closure is also executed on the main thread (because DispatchQueue.main is used).
     5. Since the main thread is already blocked, the closure cannot be executed, causing a deadlock.
     6. The app crashes due to the deadlock.

     To fix this, you can use DispatchQueue.main.async instead of DispatchQueue.main.sync:
     */
    func deadlock() {
        print("1")
        DispatchQueue.main.sync {
            print("2")
        }
    }
    
    func problem1() {// 8,1,9,10,2,3,7,4 and then crash due deadlock by sync block
        DispatchQueue.global().async {
            print("1")
            DispatchQueue.main.async {
                print("9")
            }
            DispatchQueue.main.sync {
                print("10")
            }
            DispatchQueue.global().sync {
                print("2")
            }
            print("3")
            DispatchQueue.main.async {
                print("4")
                DispatchQueue.main.sync {
                    print("5")
                }
                print("6")
            }
            print("7")
        }
        print("8")
    }
    
    func problem2() {//1,3,4,2,6,5
        DispatchQueue.global().sync {
            print("1")
            DispatchQueue.main.async {
                print("2")
                DispatchQueue.global().async {
                    print("5")
                }
                print("6")
            }
            DispatchQueue.global().sync {
                print("3")
            }
            print("4")
        }
    }
}

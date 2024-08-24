//
//  ViewController.swift
//  DispatchAndOperationQueue
//
//  Created by  Prince Shrivastav on 24/08/24.
//

import UIKit

class ViewController: UIViewController {

    let concurrentSerialVM = ConcurrentSerialQueueViewModel()
    let dispatchAsyncSyncVM = DispatchAsyncSyncViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dispatchAsyncSyncVM.problem1()
        concurrentSerialVM.debetMoneySerial()
        print("Some")
    }
    
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
   

}


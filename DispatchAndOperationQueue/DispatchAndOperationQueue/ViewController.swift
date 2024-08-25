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
    let imageViewModel = ImageProcessingViewModel()
    let debouceViewModel = DebounceTechniqueViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //concurrentSerialVM.debetMoneySerial() // ordered and some at first
        //concurrentSerialVM.debetMoneySerialSync() // ordered and some at last
        //concurrentSerialVM.debetMoneyConcurrently()// un-ordered and some print first
        //concurrentSerialVM.debetMoneyConcurrentlySync() // ordered and some at last
       // dispatchAsyncSyncVM.problem1()
        //concurrentSerialVM.concurrentIntoSerial()
        //concurrentSerialVM.serialIntoconcurrent()
//        imageViewModel.getImageURLs()
//        print("Some")
        
        debouce()
    }
    
    func debouce() {
        var number = 0
            debouceViewModel.debounce {
                for i in 0...100000 {
                    number += 1
                }
                print(number)
            }
    }
}


//
//  DispatchAsyncSyncViewModel.swift
//  DispatchAndOperationQueue
//
//  Created by  Prince Shrivastav on 24/08/24.
//

import Foundation

class DispatchAsyncSyncViewModel {
    
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

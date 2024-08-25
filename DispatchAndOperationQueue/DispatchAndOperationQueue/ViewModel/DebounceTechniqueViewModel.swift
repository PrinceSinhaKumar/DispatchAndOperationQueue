//
//  DebounceTechniqueViewModel.swift
//  DispatchAndOperationQueue
//
//  Created by  Prince Shrivastav on 25/08/24.
//

import Foundation
/*
The debounce technique is a design pattern used to prevent a function from being called too frequently, typically in scenarios where a function is triggered by user input or other events that can occur rapidly.

Here's an example of how to implement the debounce technique in Swift:

class Debouncer {
    private var workItem: DispatchWorkItem?
    private let queue: DispatchQueue
    private let delay: TimeInterval

    init(queue: DispatchQueue = .main, delay: TimeInterval = 0.5) {
        self.queue = queue
        self.delay = delay
    }

    func debounce(action: @escaping () -> Void) {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: action)
        queue.asyncAfter(deadline: .now() + delay, execute: workItem!)
    }
}

// Usage:
let debouncer = Debouncer()
debouncer.debounce {
    print("Debounced action")
}

In this example, the Debouncer class takes a queue and a delay as parameters. The debounce function cancels any existing work item and creates a new one with the provided action. The work item is then executed after the specified delay using asyncAfter.

You can use the Debouncer class to debounce functions like this:

let debouncer = Debouncer()
button.addTarget(debouncer.debounce {
    print("Button tapped")
}, for: .touchUpInside)

This will prevent the button's action from being called too frequently, even if the user taps the button rapidly.

The debounce technique is useful in scenarios like:

- Preventing excessive network requests
- Reducing the frequency of database writes
- Smoothing out rapid user input (e.g., text field input)
- Preventing multiple notifications from being sent in quick succession

Note that the debounce technique can also be implemented using other approaches, such as using a timer or a boolean flag to track whether the function is already executing. However, the DispatchWorkItem approach shown above is a concise and efficient way to implement debouncing in Swift.
*/
class DebounceTechniqueViewModel {
    private var workItem: DispatchWorkItem?
    private let queue: DispatchQueue
    private let delay: TimeInterval

    init(queue: DispatchQueue = .main, delay: TimeInterval = 10) {
        self.queue = queue
        self.delay = delay
    }

    func debounce(action: @escaping () -> Void) {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: action)
        queue.asyncAfter(deadline: .now() + delay, execute: workItem!)
    }
}

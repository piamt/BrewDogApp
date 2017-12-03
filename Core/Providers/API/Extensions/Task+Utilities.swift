//
//  Task+Utilities.swift
//  Pods
//

import Foundation
import Deferred

extension Collection where Iterator.Element : FutureProtocol, Iterator.Element.Value: Either, Iterator.Element.Value.Left == Error {
    func coalesce<SuccessValue>() -> Task<[SuccessValue]> {
        let finalTask: Task<[SuccessValue]> = allSucceeded()
            .map(upon: .main, transform: { _ -> [SuccessValue] in
                // Map each successful task into an array of SuccessValue
                self.flatMap({ (try? $0.peek()?.extract()) as? SuccessValue })
            })
        
        return finalTask
    }
}

//
//  ModuleConstants.swift
//  Pods
//

import Foundation

let ModuleName = "com.piamunoz.BrewDog"

func submoduleName(_ submodule : String) -> String {
    return ModuleName + "." + submodule
}

public func queueForSubmodule(_ submodule : String, qualityOfService: QualityOfService = .default) -> OperationQueue {
    let queue = OperationQueue()
    queue.name = submoduleName(submodule)
    queue.qualityOfService = qualityOfService
    return queue
}

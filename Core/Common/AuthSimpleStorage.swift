//
//  AuthSimpleStorage.swift
//  Pods
//

import Foundation

public protocol AuthStorageType {
    func tokenIsExpired() -> Bool
    func token() -> String?
    func setToken(_ authToken: String) throws
}

public class AuthSimpleStorage: AuthStorageType {

    public static let defaultStorage = AuthSimpleStorage()
    private init() {}
    
    public enum Constants {
        static let tokenKey = "TOKEN_KEY"
        static let gradesKey = "GRADES_KEY"
    }
    
    public func setToken(_ authToken: String) throws {
        UserDefaults.standard.setValue(authToken, forKeyPath: Constants.tokenKey)
        UserDefaults.standard.synchronize()
    }
    
    public func token() -> String? {
        return UserDefaults.standard.string(forKey: Constants.tokenKey)
    }
    
    public func tokenIsExpired() -> Bool {
        return false
    }
    
    public func removeToken() {
        UserDefaults.standard.removeObject(forKey: Constants.tokenKey)
        UserDefaults.standard.synchronize()
    }
}

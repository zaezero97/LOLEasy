//
//  UserDefaultManager.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/03.
//

import Foundation


final class UserDefaultManager {
    
    private let summonerRegistrationKey = "registeredSummoner"
     var registeredSummoner: String? {
         get {
             print("get!!")
             return UserDefaults.standard.string(forKey: summonerRegistrationKey)
         }
         set {
             print("set!!!")
             UserDefaults.standard.set(newValue, forKey: summonerRegistrationKey)
         }
    }
    
    func unRegisterSummoner() {
        UserDefaults.standard.removeObject(forKey: summonerRegistrationKey)
    }
}

//
//  UserDefaultManager.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/03.
//

import Foundation


final class UserDefaultManager {
    
     var registeredSummoner: String? {
         get {
             print("get!!")
             return UserDefaults.standard.string(forKey: "registeredSummoner")
         }
         set {
             print("set!!!")
             UserDefaults.standard.set(newValue, forKey: "registeredSummoner")
         }
    }
}

//
//  RxRegisterSummonerDelegateProxy.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation

//public class RxRegisterSummonerDeleateProxy: DelegateProxy, DelegateProxyType, CustomClassDelegate {
//        public class func currentDelegateFor(object: AnyObject) -> AnyObject? {
//            let custom: CustomClass = castOrFatalError(object)
//            return custom.delegate
//        }
//        public class func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
//            let custom: CustomClass = castOrFatalError(object)
//            custom.delegate = castOptionalOrFatalError(delegate)
//        }
//        public override class func createProxyForObject(object: AnyObject) -> AnyObject {
//            let custom = (object as! CustomClass)
//            return castOrFatalError(custom.rx_createDelegateProxy())
//        }
//    }

//
//  Observable+.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation
import RxSwift

public extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

//
//  BaseViewController.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    func configureUI() {
        
    }
}

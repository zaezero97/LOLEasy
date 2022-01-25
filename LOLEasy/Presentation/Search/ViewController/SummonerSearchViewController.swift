//
//  SummonerSearchViewController.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/25.
//

import UIKit
import RxSwift
import SnapKit

final class SummonerSearchViewController: UIViewController {
    private lazy var topColorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainColor
        return view
    }()
    
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Banner")
        return imageView
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8.0
        textField.placeholder = "소환사 닉네임을 입력해주세요."
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 15.0, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.leftView = leftPadding
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    func configureUI() {
        [
            self.topColorView,
            self.titleImageView,
            self.searchTextField
        ].forEach { self.view.addSubview($0) }
        
        
        
        self.topColorView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.frame.height / 3.0)
        }
        self.titleImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.centerY.equalTo(topColorView)
            make.height.equalTo(100)
        }
        
        self.searchTextField.snp.makeConstraints { make in
            make.centerY.equalTo(topColorView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.height.equalTo(60.0)
        }
    }
}

//
//  RecordCell.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/08.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class RecordCell: UICollectionViewCell {
    static let identifier = "RecordCell"
    
    //승,패
    private let resultLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12.0, weight: .semibold)
    }
    
    private let durationLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 11.0, weight: .medium)
    }
    private let resultView = UIView()
    private let championImageView = UIImageView()
    private let spellImageViews = [UIImageView(),UIImageView()]
    private let perkImageViews = [UIImageView(),UIImageView()]
    
    private let spellImageStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .center
    }
    
    private let perkImageStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .center
    }
    
    private let itemStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
    }
    
    private let killScoreLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .bold)
    }
    
    private let itemimageViews = [
        UIImageView(),
        UIImageView(),
        UIImageView(),
        UIImageView(),
        UIImageView(),
        UIImageView(),
        UIImageView(), // 마지막은 장신구
    ]
    
    
    private let elapsedTimeLabel = UILabel().then {
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 13.0, weight: .medium)
        $0.textAlignment = .right
    }
    
    private let characterStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    private func configureUI() {
        self.spellImageViews.forEach { self.spellImageStackView.addArrangedSubview($0) }
        self.perkImageViews.forEach { self.perkImageStackView.addArrangedSubview($0) }
        self.itemimageViews.forEach { self.itemStackView.addArrangedSubview($0) }
        
        [
            self.spellImageStackView,
            self.perkImageStackView
        ].forEach {
            self.characterStackView.addArrangedSubview($0)
        }
        
        [
            resultLabel,
            durationLabel
        ].forEach {
            self.resultView.addSubview($0)
        }
        
        [
            resultView,
            characterStackView,
            championImageView,
            killScoreLabel,
            elapsedTimeLabel,
            itemStackView
        ].forEach {
            self.contentView.addSubview($0)
        }
        
        self.resultView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(80.0)
        }
        
        self.resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(8.0)
        }
        
        self.durationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.resultLabel.snp.bottom).offset(8.0)
        }
        
        self.championImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.resultView.snp.trailing).offset(8.0)
            make.top.equalToSuperview().inset(8.0)
            make.width.height.equalTo(40.0)
        }
        
        self.characterStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.championImageView.snp.trailing)
            make.top.bottom.equalTo(self.championImageView)
        }
        
        self.killScoreLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.characterStackView.snp.trailing).offset(8.0)
            make.top.bottom.equalTo(self.championImageView)
        }
        
        self.itemStackView.snp.makeConstraints { make in
            make.top.equalTo(self.championImageView.snp.bottom).offset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
            make.leading.equalTo(self.championImageView)
            make.trailing.equalTo(self.killScoreLabel)
        }
        
        self.elapsedTimeLabel.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(8.0)
        }
    }
    
    func update(with myRecord: Participant) {
        self.championImageView.kf.setImage(
            with: URL.championIconURL(name: myRecord.championName),
            placeholder: UIImage(systemName: "face.smiling.fill"),
            options: [.processor(RoundCornerImageProcessor(cornerRadius: 16.0))]
        )
       
    }
}

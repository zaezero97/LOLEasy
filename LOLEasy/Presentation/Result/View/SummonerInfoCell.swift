//
//  SummonerInfoCell.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/08.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class SummonerInfoCell: UICollectionViewCell {
    static let identifier = "SummonerInfoCell"
    
    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24.0, weight: .bold)
    }
    
    private let levelLabel = UILabel().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = $0.frame.height / 2.0
        $0.textColor = .mainColor
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
    }
    
    private let iconImageView = UIImageView()
    
    private let renewalButton = UIButton().then {
        $0.backgroundColor = .mainColor
        $0.tintColor = .white
        $0.setTitle("전적 갱신", for: .normal)
        $0.layer.cornerRadius = 16.0
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
        
        [
            self.iconImageView,
            self.nameLabel,
            self.levelLabel,
            self.renewalButton
        ].forEach {
            self.contentView.addSubview($0)
        }
        
        self.iconImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(16.0)
            make.width.equalTo(100.0)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.iconImageView.snp.trailing).offset(16.0)
            make.trailing.equalToSuperview().inset(16.0)
            make.top.equalTo(self.iconImageView)
        }
        
        self.levelLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.iconImageView).offset(-8.0)
            make.centerX.equalTo(self.iconImageView)
        }
        
        self.renewalButton.snp.makeConstraints { make in
            make.leading.equalTo(self.iconImageView.snp.trailing).offset(16.0)
            make.bottom.equalTo(self.iconImageView)
            make.height.equalTo(50.0)
            make.width.equalTo(100.0)
        }
    }
    
    func update(with summoner: Summoner) {
        self.iconImageView.kf.setImage(
            with: URL.profileIconURL(id: summoner.profileIconId),
            placeholder: UIImage(systemName: "person.fill"),
            options: [.processor(RoundCornerImageProcessor(cornerRadius: 16.0))]
        )
        
        self.nameLabel.text = summoner.name
        self.levelLabel.text = "\(summoner.summonerLevel)"
    }
}

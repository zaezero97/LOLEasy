//
//  SummonerCardView.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

final class SummonerCardView: UIView {
    
    private let iconImageView: UIImageView = UIImageView()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tierImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var tierLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return label
    }()
    
    private(set) lazy var unRegisterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI() {
        [
            iconImageView,
            levelLabel,
            nameLabel,
            tierLabel,
            tierImageView,
            unRegisterButton
        ].forEach {
            self.addSubview($0)
        }
        
        self.isHidden = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        
        self.iconImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16.0)
            make.width.height.equalTo(70.0)
        }
        
        self.levelLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.iconImageView).offset(-8.0)
            make.leading.trailing.equalTo(self.iconImageView)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.iconImageView.snp.trailing).offset(16.0)
            make.top.equalTo(iconImageView).offset(16.0)
        }
        
        self.tierImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(32.0)
            make.leading.equalTo(iconImageView)
            make.width.height.equalTo(40.0)
        }
        
        self.tierLabel.snp.makeConstraints { make in
            make.leading.equalTo(tierImageView.snp.trailing).offset(8.0)
            make.trailing.equalToSuperview().offset(16.0)
            make.centerY.equalTo(tierImageView)
        }
        
        self.unRegisterButton.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(8.0)
            make.width.height.equalTo(30.0)
        }
    }
    
    func bind(summonerInfo: (Summoner,LeagueEntry)) {
        self.iconImageView.kf.setImage(
            with: URL(string: "https://ddragon.leagueoflegends.com/cdn/12.3.1/img/profileicon/\(summonerInfo.0.profileIconId).png")!,
            placeholder: UIImage(systemName: "person.fill"),
            options: [.processor(RoundCornerImageProcessor(cornerRadius: 16.0))]
        )
        self.tierImageView.image = summonerInfo.1.tier?.icon
        self.nameLabel.text = summonerInfo.0.name
        self.tierLabel.text = "\(summonerInfo.1.tier?.rawValue ?? "") \(summonerInfo.1.rank ?? "") \(summonerInfo.1.leaguePoints)LP"
        self.levelLabel.text = "\(summonerInfo.0.summonerLevel)"
        self.isHidden = false
    }
}

extension Reactive where Base: SummonerCardView {
    var summonerInfo: Binder<(Summoner,LeagueEntry)> {
        return Binder(self.base) { (view,info) in
            view.bind(summonerInfo: info)
        }
    }
}


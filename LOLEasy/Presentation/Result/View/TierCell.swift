//
//  TierCell.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/08.
//

import UIKit
import SnapKit
import Then



final class TierCell: UICollectionViewCell {
    static let identifier = "TierCell"
    
    private let tierImageView = UIImageView()
    
    
    private let typeLabel = UILabel().then {
        $0.textColor = .mainColor
        $0.font = .systemFont(ofSize: 11.0, weight: .medium)
    }
    
    private let tierLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .bold)
    }
    
    private let pointLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12.0, weight: .medium)
    }
    
    private let winningRateLabel = UILabel().then {
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 12.0, weight: .medium)
    }
    
    private let labelStackView = UIStackView().then {
        $0.alignment = .center
        $0.axis = .vertical
        $0.distribution = .fill
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
            self.typeLabel,
            self.tierLabel,
            self.pointLabel,
            self.winningRateLabel
        ].forEach {
            self.labelStackView.addArrangedSubview($0)
        }
        
        [
            self.tierImageView,
            self.labelStackView
            
        ].forEach {
            self.contentView.addSubview($0)
        }
        
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.secondaryLabel.cgColor.copy(alpha: 0.1)
        self.contentView.layer.cornerRadius = 6.0
        
        self.tierImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.top.bottom.equalToSuperview().inset(8.0)
            make.width.equalTo(50.0)
        }
        
        self.labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.tierImageView.snp.trailing).offset(8.0)
            make.top.bottom.equalToSuperview().inset(8.0)
            make.trailing.equalToSuperview().inset(16.0)
        }
    }
    
    func update(with league: LeagueEntry) {
        self.tierImageView.image = league.tier?.icon
        self.winningRateLabel.text = "\(league.wins)승 \(league.losses)패 (\( (league.wins + league.losses) / league.wins)%)"
        self.typeLabel.text = league.queueType.rawValue
        self.tierLabel.text = "\(league.tier?.rawValue ?? "") \(league.rank ?? "") "
        self.pointLabel.text = "\(league.leaguePoints)LP"
    }
}

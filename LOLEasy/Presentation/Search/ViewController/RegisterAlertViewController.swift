//
//  CustomAlertViewController.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/28.
//

import UIKit
import SnapKit
import RxSwift

enum Tier: String, Codable {
    case bronze = "BRONZE"
    case challenger = "CHALLENGER"
    case diamond = "DIAMOND"
    case gold = "GOLD"
    case grandmaster = "GRANDMASTER"
    case iron = "IRON"
    case master = "MASTER"
    case platinum = "PLATIUM"
    case silver = "SILVER"
    
    var icon: UIImage? {
        return UIImage(named: "Emblem_\(self.rawValue.capitalized)")
    }
    
}

final class RegisterAlertViewController: BaseViewController {
    
    private lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 16.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 16.0
        view.layer.shadowRadius = 3.0
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .init(width: 6, height: 6)
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16.0
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()
    
    private lazy var tierImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = self.leagueEntry.tier?.icon
        return imageView
    }()
    
    private lazy var tierLabel: UILabel = {
        let label = UILabel()
        label.text = self.leagueEntry.tier?.rawValue
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = self.summoner.name
        label.font = .systemFont(ofSize: 32.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.summoner.summonerLevel)"
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("등록", for: .normal)
        button.backgroundColor = UIColor.mainColor
        button.layer.cornerRadius = 16.0
        return button
    }()
    
    private lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.backgroundColor = UIColor.mainColor
        button.layer.cornerRadius = 16.0
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        stackView.alignment = .fill
        return stackView
    }()
    
   
    private let summoner: Summoner
    private let leagueEntry: LeagueEntry
    init(summoner:Summoner, leagueEntry: LeagueEntry) {
        self.summoner = summoner
        self.leagueEntry = leagueEntry
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        self.view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        
        [
            alertView
        ].forEach {
            self.view.addSubview($0)
        }
        
        [
            iconImageView,
            nameLabel,
            levelLabel,
            buttonStackView,
            tierImageView,
            tierLabel
        ].forEach {
            self.alertView.addSubview($0)
        }
        
        [
            registerButton,
            cancleButton
        ].forEach {
            self.buttonStackView.addArrangedSubview($0)
        }
        
        
        self.alertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(400.0)
            make.width.equalTo(300.0)
        }
        
        self.iconImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16.0)
            make.width.equalTo(100.0)
            make.height.equalTo(150.0)
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
            make.leading.equalTo(iconImageView.snp.trailing).inset(-16.0)
            make.width.height.equalTo(40.0)
        }

        self.tierLabel.snp.makeConstraints { make in
            make.leading.equalTo(tierImageView.snp.trailing).offset(8.0)
            make.trailing.equalToSuperview().offset(16.0)
            make.centerY.equalTo(tierImageView)
        }
      
        self.buttonStackView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(8.0)
            make.height.equalTo(80)
        }
    }
    
    
    private var summonerInfo: Binder<(Summoner,LeagueEntry)> {
        return Binder(self) { (vc, info) in
            vc.tierImageView.image = info.1.tier?.icon
            vc.tierLabel.text = info.1.tier?.rawValue
            vc.nameLabel.text = info.0.name
            vc.levelLabel.text = "\(info.0.summonerLevel)"
        }
    }
    
    func actionBinding(observer: AnyObserver<Void>) {
        self.registerButton.rx.tap
            .mapToVoid()
            .subscribe(observer)
            .disposed(by: self.disposeBag)
    }
}




import SwiftUI
struct CustomAlertViewController_Priviews: PreviewProvider {
    static var previews: some View {
        Contatiner().edgesIgnoringSafeArea(.all)
    }
    struct Contatiner: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let vc = RegisterAlertViewController(
                summoner: Summoner(accountId: "", profileIconId: 123213123213, name: "제제로", id: "", puuid: "", summonerLevel: 100),
                leagueEntry: LeagueEntry(queueType: .RANKED_SOLO_5x5, tier: .challenger, rank: "100", leaguePoints: 56, wins: 42, losses: 23)
            ) //보고 싶은 뷰컨 객체
            return vc
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

        }
        typealias UIViewControllerType =  UIViewController
    }
}



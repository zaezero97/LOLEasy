//
//  SummonerRecordViewController.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Differentiator
import Then
import RxViewController

final class SummonerRecordViewController: BaseViewController {
    let puuid = "WNSkm5zXgOPLvZ_5a0ZKJxbOSIn-LLQ51PlamEZXxu4ExuRybHHX8UJ169lxeBl_ijCph-Ur6502Pw"
    let collectionview = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0
    }
    
    let name: String
    var viewModel: SummonerRecordViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.name = ""
        super.init(coder: coder)
    }
    
    override func bind() {
        
        let input = SummonerRecordViewModel.Input(
            viewDidLoad: Observable.just(name)
        )
       
        let output = self.viewModel.transform(from: input)
        
        output.summonerInfo
            .drive(onNext: {
                print($0)
            })
            .disposed(by: self.disposeBag)
        
        output.matches
            .drive(onNext: {
                print("matach",$0)
            })
            .disposed(by: self.disposeBag)
    }
    
    override func configureUI() {
       // self.view.addSubview(collectionView)
        self.view.backgroundColor = .systemBackground
        
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalTo(self.view.safeAreaLayoutGuide)
//        }
    }
}


private extension SummonerRecordViewController {
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout {
            [weak self] section, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            switch section {
            case 0:
                return self.createSummonerInfoLayout()
            case 1:
                return self.createRecordLayout()
            default:
                return nil
            }
        }
    }
    
    func createSummonerInfoLayout() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        return section
    }
    
    func createRecordLayout() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        return section
    }
}

enum SearchResultSectionModel {
    case summonerInfoSection(title: String, items: [SectionItem])
    case recordSection(title: String, items: [SectionItem])
}
enum SectionItem {
    case summonerInfoSectionItem(info: (summoner: Summoner, league: LeagueEntry))
   // case recordSectionItem()
}

import SwiftUI
struct SummonerRecordViewController_Priviews: PreviewProvider {
    static var previews: some View {
        Contatiner().edgesIgnoringSafeArea(.all)
    }
    struct Contatiner: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let vc = SummonerRecordViewController(name: "Zaezero") //보고 싶은 뷰컨 객체
            return UINavigationController(rootViewController: vc)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        typealias UIViewControllerType =  UIViewController
    }
}

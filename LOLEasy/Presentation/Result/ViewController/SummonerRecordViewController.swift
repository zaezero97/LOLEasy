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
import RxDataSources
import Then
import RxViewController

final class SummonerRecordViewController: BaseViewController {
    let puuid = "WNSkm5zXgOPLvZ_5a0ZKJxbOSIn-LLQ51PlamEZXxu4ExuRybHHX8UJ169lxeBl_ijCph-Ur6502Pw"
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.register(SummonerInfoCell.self, forCellWithReuseIdentifier: SummonerInfoCell.identifier)
        $0.register(TierCell.self, forCellWithReuseIdentifier: TierCell.identifier)
        $0.register(RecordCell.self, forCellWithReuseIdentifier: RecordCell.identifier)
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
        
        let dataSource = self.createDataSource()
        
        output.summonerInfo
            .map { (summoner,league) -> [SearchResultSectionModel] in
                let infoItem = SectionItem.summonerInfoSectionItem(summoner: summoner)
                let tierItem = SectionItem.tierSectionItem(league: league)
                return [
                    SearchResultSectionModel.summonerInfoSection(title: "info", items: [infoItem]),
                    SearchResultSectionModel.tierSection(title: "tier", items: [tierItem])
                ]
            }
            .drive(self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
        
        output.matches
            .drive(onNext: {
                print("matach",$0)
            })
            .disposed(by: self.disposeBag)
    }
    
    override func configureUI() {
        self.view.addSubview(collectionView)
        self.view.backgroundColor = .systemBackground
        collectionView.collectionViewLayout = self.createLayout()
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
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
                return self.createTierLayout()
            case 2:
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(250.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        return section
    }
    
    func createTierLayout() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .estimated(130.0))
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
    
    func createDataSource() -> RxCollectionViewSectionedReloadDataSource<SearchResultSectionModel> {
        return RxCollectionViewSectionedReloadDataSource<SearchResultSectionModel>(configureCell: {
            datasource, collectionView, indexPath, item in
                print(indexPath)
                switch item {
                case .summonerInfoSectionItem(summoner: let summoner):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummonerInfoCell.identifier, for: indexPath) as! SummonerInfoCell
                    cell.update(with: summoner)
                    return cell
                case .tierSectionItem(league: let league):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TierCell.identifier, for: indexPath) as! TierCell
                    cell.update(with: league)
                    return cell
                case .recordSectionItem(match: let match):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCell.identifier, for: indexPath) as! RecordCell
                    cell.update(with: match)
                    return cell
                }
        },configureSupplementaryView: {
            datasource, collectionView, kind, indexPath in
            return UICollectionReusableView()
        })
        
    }
    

}



enum SearchResultSectionModel {
    case summonerInfoSection(title: String, items: [SectionItem])
    case tierSection(title: String, items: [SectionItem])
    case recordSection(title: String, items: [SectionItem])
}
enum SectionItem {
    case summonerInfoSectionItem(summoner: Summoner)
    case tierSectionItem(league: LeagueEntry)
    case recordSectionItem(match: Match)
}

extension SearchResultSectionModel: SectionModelType {
    init(original: SearchResultSectionModel, items: [SectionItem]) {
        switch original {
        case .summonerInfoSection(title: let title, _):
            self = .summonerInfoSection(title: title, items: items)
        case .tierSection(title: let title, items: _):
            self = .tierSection(title: title, items: items)
        case .recordSection(title: let title, items: _):
            self = .recordSection(title: title, items: items)
        }
    }
    
    typealias Item = SectionItem
    
    var items: [Item] {
        switch self {
        case .summonerInfoSection(_, let items):
            return items
        case .tierSection(_, let items):
            return items
        case .recordSection(title: _, items: let items):
            return items
        }
    }
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

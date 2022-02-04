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

final class SummonerRecordViewController: BaseViewController {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bind() {
        self.view.backgroundColor = .systemBackground
    }
    
    override func configureUI() {
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
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
            let vc = SummonerRecordViewController() //보고 싶은 뷰컨 객체
            return UINavigationController(rootViewController: vc)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        typealias UIViewControllerType =  UIViewController
    }
}

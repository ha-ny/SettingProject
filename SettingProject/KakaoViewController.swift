//
//  KakaoViewController.swift
//  SettingProject
//
//  Created by 김하은 on 2023/09/16.
//

import UIKit
import SnapKit

class KakaoViewController: UIViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    var dataSource: UICollectionViewDiffableDataSource<String, MenuList>?
    
    enum Section: String {
        case all = "전체 설정"
        case personal = "개인 설정"
        case etc = "기타"
    }
    
    struct MenuList: Hashable {
        let id = UUID().uuidString
        let title: String
    }
    
    var list = [
        MenuList(title: "공지사항"),
        MenuList(title: "실험실"),
        MenuList(title: "버전 정보")
    ]
    
    var list2 = [
        MenuList(title: "개인/보안"),
        MenuList(title: "알림"),
        MenuList(title: "채팅"),
        MenuList(title: "멀티프로필")
    ]
    
    var list3 = [
        MenuList(title: "고객센터/도움말")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "설정"
        view.backgroundColor = .systemGray6
        cellConfigureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<String, MenuList>()
        snapshot.appendSections([Section.all.rawValue, Section.personal.rawValue, Section.etc.rawValue])
        snapshot.appendItems(list, toSection: Section.all.rawValue)
        snapshot.appendItems(list2, toSection: Section.personal.rawValue)
        snapshot.appendItems(list3, toSection: Section.etc.rawValue)
        
        dataSource?.apply(snapshot)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func cellConfigureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, MenuList> { cell, indexPath, itemIdentifier in
            
            //셀 디자인 및 데이터 처리
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.textProperties.color = .black
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    static private func createLayout() -> UICollectionViewLayout {
        //컬렉션뷰를 테이블뷰 스타일처럼 사용 가능 (ListConfiguration)
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.showsSeparators = true
        configuration.backgroundColor = .systemGray6
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
}

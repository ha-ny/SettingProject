//
//  AppleViewController.swift
//  SettingProject
//
//  Created by 김하은 on 2023/09/16.
//

import UIKit
import SnapKit
                  
class AppleViewController: UIViewController {

    struct MenuList: Hashable {
        let id = UUID().uuidString
        let title: String
        let imageName: String?
        let detail: String?
        let isSideText: Bool
    }
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
    var list = [
        MenuList(title: "방해 금지 모드", imageName: "moon", detail: "켬", isSideText: true),
        MenuList(title: "수면", imageName: "bed.double", detail: nil, isSideText: false),
        MenuList(title: "업무", imageName: "iphone.gen2", detail: "9:00~06:00", isSideText: false),
        MenuList(title: "개인 시간", imageName: "person", detail: "설정", isSideText: true)
    ]
    
    var list2 = [
        MenuList(title: "모든 기기에서 공유", imageName: nil, detail: nil, isSideText: false)
    ]

    var dataSource: UICollectionViewDiffableDataSource<String?, MenuList>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "집중 모드"
        view.backgroundColor = .systemGray6
        cellConfigureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<String?, MenuList>()
        snapshot.appendSections(["모드 설정", nil])
        snapshot.appendItems(list, toSection: "모드 설정")
        snapshot.appendItems(list2)
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

            content.prefersSideBySideTextAndSecondaryText = itemIdentifier.isSideText
            // prefersSideBySideTextAndSecondaryText -> false면 secondaryText가 아래로 내려감
            content.secondaryText = itemIdentifier.detail
            content.textProperties.color = .darkGray
            
            if let image = itemIdentifier.imageName {
                content.image = UIImage(systemName: image)
            }

            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.accessories = [.disclosureIndicator()]
            return cell
        })
    }

    static private func createLayout() -> UICollectionViewLayout {
        //컬렉션뷰를 테이블뷰 스타일처럼 사용 가능 (ListConfiguration)
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = true
        configuration.backgroundColor = .systemGray6
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
}

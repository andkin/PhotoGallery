//
//  PhotosView.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit
import SnapKit

protocol PhotosViewDelegate: AnyObject {
    func didChangeLayout(layoutType: LayoutType)
    func loadNextPage()
}

class PhotosView: UIView {
    
    weak var delegate: PhotosViewDelegate?
    
    private lazy var collectionView: UICollectionView =  UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private let layoutSegmentedControl = UISegmentedControl(items: LayoutType.allCases.map({ $0.title }))
    
    private var dataSource: PhotosDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(props: PhotosProps) {
        layoutSegmentedControl.selectedSegmentIndex = props.layoutType.rawValue
        dataSource?.apply(props: props)
    }
}

// MARK: - Configure
private extension PhotosView {
    func configureView() {
        layoutSegmentedControl.addTarget(
            self,
            action: #selector(didChangeLayoutSegmentedControlValue(control:)),
            for: .valueChanged
        )
        
        backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.register(cell: PhotosSpinnerCell.self)
        collectionView.register(cell: PhotosItemCell.self)
        
        addSubview(layoutSegmentedControl)
        addSubview(collectionView)
        
        layoutSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(layoutSegmentedControl.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func didChangeLayoutSegmentedControlValue(control: UISegmentedControl) {
        guard let layoutType = LayoutType(rawValue: control.selectedSegmentIndex) else { return }
        self.delegate?.didChangeLayout(layoutType: layoutType)
    }
    
    func configureDataSource() {
        dataSource = PhotosDataSource(collectionView: collectionView) { (collectionView, indexPath, item) in
            switch item {
            case .spinner(let isActive):
                guard let cell: PhotosSpinnerCell = collectionView.dequeueReusableCell(for: indexPath) else { break }
                cell.update(isActive: isActive)
                return cell
            case .photo(let item, let layoutType):
                guard let cell: PhotosItemCell = collectionView.dequeueReusableCell(for: indexPath) else { break }
                cell.update(item: item, layoutType: layoutType)
                return cell
            }
            return UICollectionViewCell()
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            guard let sectionIdentifiers = self?.dataSource?.snapshot().sectionIdentifiers else { return nil }
            return sectionIdentifiers[sectionIndex].layoutKind.section(layoutEnvironment: layoutEnvironment)
        }
        return layout
    }
}

//MARK: - SectionIdentifierType, ItemIdentifierType
extension PhotosView {
    enum Section: Hashable {
        case main(layoutType: LayoutType)
        
        fileprivate var layoutKind: SectionLayoutKind {
            switch self {
            case .main(let layoutType):
                return .list(layoutType: layoutType)
            }
        }
    }
    
    enum Item: Hashable {
        case spinner(isActive: Bool)
        case photo(item: Photo, layoutType: LayoutType)
    }
}

// MARK: - SectionLayoutKind
private extension PhotosView {
    enum SectionLayoutKind {
        case list(layoutType: LayoutType)
        
        func section(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
            switch self {
            case .list(let layoutType):
                switch layoutType {
                case .list:
                    return createListSection(layoutEnvironment: layoutEnvironment)
                case .grid:
                    return createGridSection(layoutEnvironment: layoutEnvironment)
                }
            }
        }
        
        private func createListSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .estimated(44))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(44))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            return section
        }
        
        private func createGridSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .estimated(44))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(44))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: 3)
            group.interItemSpacing = .fixed(12)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 12
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            return section
        }
    }
}

// MARK: - UICollectionViewDelegate
extension PhotosView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .spinner:
            delegate?.loadNextPage()
        default:
            break
        }
    }
}

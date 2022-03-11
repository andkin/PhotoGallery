//
//  PhotosItemCell.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit
import SnapKit

class PhotosItemCell: UICollectionViewCell {
    
    private let photoImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(item: Photo) {
        photoImageView.setImage(with: item.urls.regular, placeholder: nil)
        userNameLabel.text = item.user.name
        descriptionLabel.text = item.description ?? "No description"
    }
}

// MARK: - Configure view
private extension PhotosItemCell {
    func configureView() {
        backgroundColor = .systemFill
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        userNameLabel.font = .boldSystemFont(ofSize: 16)
        descriptionLabel.font = .systemFont(ofSize: 14)
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(descriptionLabel)
        
        photoImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(photoImageView.snp.width).priority(.high)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.top.equalTo(photoImageView.snp.bottom).offset(4)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.top.equalTo(userNameLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(4)
        }
    }
}

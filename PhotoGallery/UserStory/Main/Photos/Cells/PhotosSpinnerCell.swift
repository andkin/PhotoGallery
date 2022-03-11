//
//  PhotosSpinnerCell.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit
import SnapKit

class PhotosSpinnerCell: UICollectionViewCell {
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(isActive: Bool) {
        isActive ? spinner.startAnimating() : spinner.stopAnimating()
    }
}

// MARK: - Configure
private extension PhotosSpinnerCell {
    func configureView() {
        contentView.addSubview(spinner)
        
        spinner.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.center.equalToSuperview()
        }
    }
}

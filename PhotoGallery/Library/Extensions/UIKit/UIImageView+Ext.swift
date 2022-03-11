//
//  UIImageView+Ext.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation
import Kingfisher

extension UIImageView {
    @discardableResult
    func setImage(with urlString: String?,
                  placeholder: UIImage?) -> UIImageView {
        kf.indicatorType = .activity
        kf.setImage(with: URL(string: urlString ?? ""),
                    placeholder: placeholder)
        
        return self
    }
}

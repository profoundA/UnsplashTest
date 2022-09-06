//
//  PhotoCell.swift
//  UnsplashTest
//
//  Created by Andrey Lobanov on 05.09.2022.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
    
    static let reuseID = "PhotoCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var setupCell: Photo? {
        didSet {
            guard let setupCell = setupCell else { return }
            self.imageView.sd_setImage(with: URL(string: setupCell.urls.regular))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor)
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

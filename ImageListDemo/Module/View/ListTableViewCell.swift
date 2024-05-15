//
//  ListTableViewCell.swift
//  ImageListDemo
//
//  Created by Bishal Ram on 15/05/24.
//

import UIKit
import Stevia

class ListTableViewCell: UITableViewCell {

    let mainImageView: LazyImageView = {
        let imageView = LazyImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: // LifeCycle Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
    }
    
    private func setupLayout() {
        contentView.subviews {
            mainImageView
        }
        
        mainImageView.Top == Top + Constants.verticalSpacing
        mainImageView.Bottom == Bottom + Constants.verticalSpacing
        mainImageView.fillHorizontally()
    }
    
    // MARK: // Public Methods
    func setupContent(imageURL: URL, placeHolderURL: URL) {
        mainImageView.loadImage(imageURL, placeHolderURL)
    }
    
    private enum Constants {
        static let horizontalSpacing: CGFloat = 8.0
        static let verticalSpacing: CGFloat = 8.0
        static let imageViewSize: CGFloat = 200
    }
}

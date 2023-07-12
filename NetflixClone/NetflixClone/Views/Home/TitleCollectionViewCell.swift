//
//  TitleCollectionViewCell.swift
//  NetflixClone
//
//  Created by Burak Emre gündeş on 11.07.2023.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private lazy var posterImageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model : String) {
        guard let url = URL(string:"https://image.tmdb.org/t/p/w500" + model) else {return}
       
        posterImageView.sd_setImage(with: url)
    }
    
}

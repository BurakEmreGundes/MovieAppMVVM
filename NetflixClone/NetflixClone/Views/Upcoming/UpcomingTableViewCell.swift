//
//  UpcomingTableViewCell.swift
//  NetflixClone
//
//  Created by Burak Emre gündeş on 12.07.2023.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    static let identifier = "UpcomingTableViewCell"
    
    private lazy var movieImageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var titleLabel : UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        return lb
    }()
  
    private lazy var playButton : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private func applyConstraints(){
        
        let movieImageViewConstraints = [
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            movieImageView.heightAnchor.constraint(equalToConstant: 140),
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            titleLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width - 140)
        ]
        
        let playButtonConstraints = [
            playButton.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor),
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16)
        ]
        
        NSLayoutConstraint.activate(movieImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
        
    }
    
    private func setupUI(){
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
        
        applyConstraints()
    }
    
    public func configure(with model : UpcomingUIModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + model.posterURL) else {return}
        
        movieImageView.sd_setImage(with: url)
        titleLabel.text = model.titleName
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}

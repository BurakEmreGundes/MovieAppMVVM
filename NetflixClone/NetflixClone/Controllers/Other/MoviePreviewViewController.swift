//
//  MoviePreviewViewController.swift
//  NetflixClone
//
//  Created by Burak Emre gündeş on 15.07.2023.
//

import UIKit
import WebKit

class MoviePreviewViewController: UIViewController {
    
    private lazy var webView : WKWebView = {
       let wb = WKWebView()
        wb.translatesAutoresizingMaskIntoConstraints = false
       return wb
    }()

    private lazy var titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 22, weight: .bold)
        lbl.text = "Title Label"
        return lbl
    }()
    
    private lazy var overviewLabel : UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 18, weight: .regular)
        lbl.text = "Overview Label Deneme Text Maksat Dolu Gözüksün"
        lbl.numberOfLines = 0
      return lbl
    }()
    
    private lazy var downloadButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .red
        btn.setTitle("Download", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8.0
        btn.layer.masksToBounds = true
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI(){
        title = "Preview"
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
        applyConstraints()
    }
    
    
    private func applyConstraints(){
        
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            webView.heightAnchor.constraint(equalToConstant: 300),
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ]
        
        let downloadButtonConstraint = [
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
            downloadButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 4),
            
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraint)
        
        
    }
    
    public func configure(with model : MoviewPreviewUIModel){
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {return}
        
        webView.load(URLRequest(url: url))
     }
    
    
    

}

//
//  UpcomingViewController.swift
//  NetflixClone
//
//  Created by Burak Emre gündeş on 10.07.2023.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var upcomingMovies = [Movie]() {
        didSet {
            DispatchQueue.main.async {[weak self] in
                self?.upcomingTableView.reloadData()
            }
        }
    }

    private lazy var upcomingTableView : UITableView = {
        let tv = UITableView()
        tv.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    
    var viewModel : UpcomingViewModel
    
    init(viewModel : UpcomingViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNav()
        viewModel.fetchUpcomingMovies()
    }
    
    private func setupUI(){
        view.addSubview(upcomingTableView)
    }
    
    
    private func setupNav(){
        title = "Upcoming"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTableView.frame = view.bounds
    }
    
    
    
}

extension UpcomingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {return UITableViewCell()}
        cell.configure(with: UpcomingUIModel(titleName: upcomingMovies[indexPath.row].original_name ?? (upcomingMovies[indexPath.row].original_title ?? "Unkown"), posterURL: upcomingMovies[indexPath.row].poster_path ?? ""))
        cell.selectionStyle = .none
        return cell
    }
}

extension UpcomingViewController : UpcomingViewModelOutput {
    func fetchUpcomingMoviesOutput(result: Result<[Movie], Error>) {
        switch result {
        case .success(let movies):
            self.upcomingMovies = movies
        case .failure(let error):
            print(error)
        }
    }
}

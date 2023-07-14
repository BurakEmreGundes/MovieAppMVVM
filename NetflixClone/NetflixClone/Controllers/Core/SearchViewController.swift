//
//  SearchViewController.swift
//  NetflixClone
//
//  Created by Burak Emre gündeş on 10.07.2023.
//

import UIKit

class SearchViewController: UIViewController {
    private var discoverMovies = [Movie]() {
        didSet {
            DispatchQueue.main.async {[weak self] in
                self?.discoverTableView.reloadData()
            }
        }
    }

    private lazy var discoverTableView : UITableView = {
        let tv = UITableView()
        tv.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private lazy var searchController : UISearchController = {
       let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for a Movie or a Tv Show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    var viewModel : SearchViewModel
    
    init(viewModel : SearchViewModel){
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
        view.addSubview(discoverTableView)
    }
    
    
    private func setupNav(){
        title = "Upcoming"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        self.navigationItem.searchController = searchController
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTableView.frame = view.bounds
    }
    
    
    
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.discoverMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {return UITableViewCell()}
        cell.configure(with: UpcomingUIModel(titleName: discoverMovies[indexPath.row].original_name ?? (discoverMovies[indexPath.row].original_title ?? "Unkown"), posterURL: discoverMovies[indexPath.row].poster_path ?? ""))
        cell.selectionStyle = .none
        return cell
    }
}

extension SearchViewController : SearchViewModelOutput {
    func fetchDiscoverMoviesOutput(result: Result<[Movie], Error>) {
        switch result {
        case .success(let movies):
            self.discoverMovies = movies
        case .failure(let error):
            print(error)
        }
    }
}

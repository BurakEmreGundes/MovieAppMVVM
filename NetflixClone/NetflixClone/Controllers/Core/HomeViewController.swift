//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Burak Emre gündeş on 10.07.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles : [String] = ["Trending Movies", "Popular", "Trending Tv", "Upcoming Movies", "Top Rated"]
    
    
    private var selectedMovie : Movie? = nil
    
    private lazy var homeTableView : UITableView = {
        let tbv = UITableView(frame: .zero, style: .grouped)
        tbv.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tbv
    }()
    
    let viewModel : HomeViewModel
    
    init(viewModel : HomeViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupUI()
        configureTableView()
        configureNavBar()
    }
     
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTableView.frame = view.bounds
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: 0)
    }
    
    private lazy var leftBarNetflixButton : UIButton = {
        let btn = UIButton(type: .custom)
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        btn.setImage(image, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private func configureNavBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarNetflixButton)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
    }
    
    private func configureTableView(){
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.tableHeaderView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
    }
    
    private func setupUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(homeTableView)
        applyConstraints()
    }
    
    private func applyConstraints(){
        leftBarNetflixButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        leftBarNetflixButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    private func fetchData(){
        viewModel.fetchAllMovies {[weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.homeTableView.reloadData()
                }
            }
        }
    }
    
    private func gotoMoviewPreview(with model : MoviewPreviewUIModel){
        let vc = MoviePreviewViewController()
        vc.configure(with: model)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.delegate = self
        
        switch indexPath.section {
        case 0 :
            cell.configure(with: viewModel.trendingMovies)
        case 1:
            cell.configure(with: viewModel.popularMovies)
        case 2:
            cell.configure(with: viewModel.trendingTVs)
        case 3:
            cell.configure(with: viewModel.upcomingMovies)
        case 4:
            cell.configure(with: viewModel.topRatedMovies)
        default:
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
         
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalized(with: .current)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        
    }
    
    
}

extension HomeViewController : CollectionViewTableViewCellDelegate {
    func tappedCell(q: String, selectedMovie: Movie) {
        self.selectedMovie = selectedMovie
        viewModel.getMoviefromYoutube(q: q)
    }
}

extension HomeViewController : HomeViewModelOutput {
    
    func getMoviefromYoutubeOutput(result: Result<VideoElement, Error>) {
        switch result {
        case .success(let videoElement):
            print(videoElement.id)
            
            guard let selectedMovie = selectedMovie, let titleName = selectedMovie.original_title ?? selectedMovie.original_name, let titleOverview = selectedMovie.overview else {return}
            
            let model = MoviewPreviewUIModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview)
            DispatchQueue.main.async { [weak self] in
                self?.gotoMoviewPreview(with: model)
            }
        case .failure(let error):
            self.selectedMovie = nil
            print(error)
        }
    }
    

    
}

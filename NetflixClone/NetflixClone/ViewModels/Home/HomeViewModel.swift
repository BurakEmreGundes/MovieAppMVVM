//
//  HomeViewModel.swift
//  NetflixClone
//
//  Created by Burak Emre gündeş on 12.07.2023.
//

import Foundation


protocol HomeViewModelOutput : AnyObject{
    func fetchAllMoviesOutput()
}


class HomeViewModel {
    
    weak var delegate : HomeViewModelOutput?
    
    var trendingMovies: [Movie] = []
    var trendingTVs: [Movie] = []
    var upcomingMovies: [Movie] = []
    var popularMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    
    func fetchAllMovies(completion : @escaping (Bool) -> Void){
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "com.example.myqueue", attributes: .concurrent)
        
        var status : Bool = true

    
        // Trending Movies isteği
        dispatchGroup.enter()
        dispatchQueue.async {
            APICaller.shared.getTrendingMovies {[weak self] response in
                defer { dispatchGroup.leave() }
                switch response {
                case .success(let movies):
                    self?.trendingMovies = movies
                case .failure(let error):
                    status = false
                    print(error.localizedDescription)
                }
            }
        }

        // Trending TVs isteği
        dispatchGroup.enter()
        dispatchQueue.async {
            APICaller.shared.getTrendingTvs {[weak self] response in
                defer { dispatchGroup.leave() }
                switch response {
                case .success(let tvs):
                    self?.trendingTVs = tvs
                case .failure(let error):
                    status = false
                    print(error.localizedDescription)
                }
            }
        }
        
        // Upcoming Movies isteği
        dispatchGroup.enter()
        dispatchQueue.async {
            APICaller.shared.getUpcomingMovies {[weak self] response in
                defer { dispatchGroup.leave() }
                switch response {
                case .success(let movies):
                    self?.upcomingMovies = movies
                case .failure(let error):
                    status = false
                    print(error.localizedDescription)
                }
            }
        }
        
        // Popular Movies isteği
        dispatchGroup.enter()
        dispatchQueue.async {
            APICaller.shared.getPopularMovies {[weak self] response in
                defer { dispatchGroup.leave() }
                switch response {
                case .success(let movies):
                    self?.popularMovies = movies
                case .failure(let error):
                    status = false
                    print(error.localizedDescription)
                }
            }
        }

        // Top Rated Movies isteği
        dispatchGroup.enter()
        dispatchQueue.async {
            APICaller.shared.getTopRatedMovies {[weak self] response in
                defer { dispatchGroup.leave() }
                switch response {
                case .success(let movies):
                    self?.topRatedMovies = movies
                case .failure(let error):
                    status = false
                    print(error.localizedDescription)
                }
            }
        }

        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("trending movies \(String(describing: self.trendingMovies))")
            print("trending tvs \(String(describing: self.trendingTVs))")
            print("popular movies \(String(describing: self.popularMovies))")
            print("upcoming movies \(String(describing: self.upcomingMovies))")
            completion(status)
        }
    }
    
}




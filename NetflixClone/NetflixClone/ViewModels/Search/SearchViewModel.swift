//
//  SearchViewModel.swift
//  NetflixClone
//
//  Created by Burak Emre gündeş on 14.07.2023.
//

import Foundation


protocol SearchViewModelOutput : AnyObject {
    func fetchDiscoverMoviesOutput(result: Result<[Movie], Error>)
}

struct SearchViewModel {
    
    weak var output : SearchViewModelOutput?
    
    func fetchUpcomingMovies(){
        APICaller.shared.getDiscoverMovies { result in
            switch result {
            case .success(let movies):
                output?.fetchDiscoverMoviesOutput(result: .success(movies))
            case .failure(let error):
                output?.fetchDiscoverMoviesOutput(result: .failure(error))
            }
        }
    }
    
}

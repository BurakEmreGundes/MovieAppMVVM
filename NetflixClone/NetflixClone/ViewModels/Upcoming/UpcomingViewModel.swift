//
//  UpcomingViewModel.swift
//  NetflixClone
//
//  Created by Burak Emre gündeş on 12.07.2023.
//

import Foundation


protocol UpcomingViewModelOutput : AnyObject {
    func fetchUpcomingMoviesOutput(result: Result<[Movie], Error>)
}

struct UpcomingViewModel {
    
    weak var output : UpcomingViewModelOutput?
    
    func fetchUpcomingMovies(){
        APICaller.shared.getUpcomingMovies { result in
            switch result {
            case .success(let movies):
                output?.fetchUpcomingMoviesOutput(result: .success(movies))
            case .failure(let error):
                output?.fetchUpcomingMoviesOutput(result: .failure(error))
            }
        }
    }
    
}

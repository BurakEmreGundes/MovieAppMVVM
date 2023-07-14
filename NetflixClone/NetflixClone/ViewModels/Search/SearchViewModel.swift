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
    
    
    func search(with query : String, completion: @escaping (Result<[Movie], Error>)  -> Void){
        APICaller.shared.search(with: query) { result in
            completion(result)
        }
    }
    
    func fetchUpcomingMovies(){
        APICaller.shared.getDiscoverMovies { result in
            output?.fetchDiscoverMoviesOutput(result: result)
        }
    }
    
}

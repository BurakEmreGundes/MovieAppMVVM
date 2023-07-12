//
//  APICaller.swift
//  NetflixClone
//
//  Created by Burak Emre gündeş on 11.07.2023.
//

import Foundation



class APICaller {
    
    struct Constants {
        static let API_KEY = "8766b4915e979ef7c97d4e60e5fb4c6e"
        static let baseURL = "https://api.themoviedb.org"
    }
    
    enum APIError : Error {
        case failedtoGetData
    }
    
    static let shared = APICaller()
    private init(){}
    
    
    func getTrendingMovies(completion : @escaping (Result<[Movie], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
               // let result = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.failedtoGetData))
            }
            
        }
        task.resume()
    }
    
    func getTrendingTvs(completion : @escaping (Result<[Movie],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
               
            }catch{
                completion(.failure(APIError.failedtoGetData))
            }
            
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion : @escaping (Result<[Movie], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.failedtoGetData))
            }
            
        }
        task.resume()
    }
    
    func getPopularMovies(completion : @escaping (Result<[Movie], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.failedtoGetData))
            }
            
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion : @escaping (Result<[Movie], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.failedtoGetData))
            }
            
        }
        task.resume()
    }
    
 
}

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
        static let YoutubeAPI_KEY = "AIzaSyBV5avLK5Y8plcf_ljroRy1gPcEUb62d-A"
        static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
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
    
    func getDiscoverMovies(completion : @escaping (Result<[Movie], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
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
    
    func search(with query : String, completion : @escaping (Result<[Movie], Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        
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
    
    func getMovie(with query : String, completion : @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(result.items[0]))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
 
}

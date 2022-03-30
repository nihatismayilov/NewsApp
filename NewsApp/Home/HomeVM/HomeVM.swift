//
//  HomeVM.swift
//  NewsApp
//
//  Created by Nihad Ismayilov on 30.03.22.
//

import Foundation

struct Trial {
    
    let url = "https://api.newscatcherapi.com"
    let apiKey = "v9jAhBlFv8cxgRmUVNZv4gtbiIC1McOArN7itppIpzk"
    
    func tests() {
        
    }
    
}




struct SearchViewModel {
    
    let searchUrl = "https://api.newscatcherapi.com/v2/search?q=Tesla"
    
    
    // v9jAhBlFv8cxgRmUVNZv4gtbiIC1McOArN7itppIpzk
    
    
    
    
    func test(_ SearchNewsTitle: String, completion: @escaping (SearchNews) -> ()) {
        
        let url = URL(string: "http://localhost:1337/parse/test")!
           let requestUrl = url    // Prepare URL Request Object
           var request = URLRequest(url: requestUrl)
        
        
           
           request.setValue("application-idValue", forHTTPHeaderField: "X-Parse-Application-Id")
           request.setValue("secret-keyValue", forHTTPHeaderField: "b10bb5d0587e4518a20031605636ab85")
           
           request.httpMethod = "POST"
        
    }
    
    
    
    func performMoviesRequest(_ SearchNewsTitle: String, completion: @escaping (SearchNews?) -> ()) {
        
        let url = URL(string: searchUrl)
        let request = NSURLRequest(url: url!)
        
        
        let replaced = SearchNewsTitle.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlString = searchUrl + (replaced ?? "")
        
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            
            //print(url)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                } else {
                    if data != nil {
                        do {
                            let decodeData = try JSONDecoder().decode(SearchNews.self, from: data!)
                            //print(decodeData)
                            completion(decodeData)
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                    }
                }
            }
            task.resume()
        }
        
    }
}

struct LatestNewsViewModel {
    
    let latestNewsUrl = "http://www.omdbapi.com/?i=tt3896198&apikey=8bd48c99&s="
    
    func performMoviesRequest(completion: @escaping (SearchNews?) -> ()) {
        
        if let url = URL(string: latestNewsUrl) {
            let session = URLSession.shared
            
            //print(url)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                } else {
                    if data != nil {
                        do {
                            let decodeData = try JSONDecoder().decode(SearchNews.self, from: data!)
                            //print(decodeData)
                            completion(decodeData)
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                    }
                }
            }
            task.resume()
        }
        
    }
}


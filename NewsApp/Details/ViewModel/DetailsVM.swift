//
//  DetailsVM.swift
//  NewsApp
//
//  Created by Nihad Ismayilov on 01.04.22.
//

import Foundation

struct DetailsViewModel {
    
    func NewsDetails(_ DetailsText: String, completion: @escaping (DetailsModel?) -> ()) {
        
        let string = "https://api.newscatcherapi.com/v2/search?countries=US&q=\(DetailsText)"
        
        guard let url = URL(string: string) else { return }
        let request = NSMutableURLRequest(url: url as URL)
        request.setValue("v9jAhBlFv8cxgRmUVNZv4gtbiIC1McOArN7itppIpzk", forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        let session = URLSession.shared

        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let data = data {
                    do {
                        let decode = try JSONDecoder().decode(DetailsModel.self, from: data)
                        print(decode)
                        completion(decode)
                    } catch{
                        print(error.localizedDescription)
                    }
            }
        
            }
        }
        task.resume()
    }

}

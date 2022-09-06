//
//  NetworkService.swift
//  UnsplashTest
//
//  Created by Andrey Lobanov on 05.09.2022.
//

import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    private let url = "https://api.unsplash.com"
    private let accessKey = "T5nbPIyBqKPit45PeXoCz2VFU41elDTKbLBfhrHj_8o"
    
    func fetchPhotos(completion: @escaping ([Photo]) -> Void) {
        AF.request("\(url)/photos/random?count=30&client_id=\(accessKey)")
            .responseDecodable(of: [Photo].self) { response in
                switch response.result {
                    
                case .success(let result):
                    completion(result)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
//    func searchPhotos(query: String, completion: @escaping (SearchResults?) -> Void) {
//
//        let urlString = "\(baseUrlString)/search/photos?page=1&per_page=20&query=\(query)&orientation=squarish&client_id=\(accessKey)"
//
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard
//                let data = data,
//                error == nil,
//                let response = response as? HTTPURLResponse,
//                response.statusCode >= 200 && response.statusCode < 300 else { return }
//
//            do {
//                let photos = try JSONDecoder().decode(SearchResults.self, from: data)
//                DispatchQueue.main.async {
//                    completion(photos)
//                }
//            } catch let error {
//                print(error)
//            }
//        }.resume()
//    }
    
    func searchPhotos(searchText: String, completion: @escaping (PhotoModel?) -> Void) {
        AF.request("\(url)/search/photos?page=1&per_page=30&query=\(searchText)&client_id=\(accessKey)")
            .responseDecodable(of: PhotoModel.self) { response in
                switch response.result {
                    
                case .success(let result):
                    completion(result)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
}

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

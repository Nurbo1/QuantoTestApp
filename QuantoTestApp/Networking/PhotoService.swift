//
//  PhotoService.swift
//  QuantoTestApp
//
//  Created by Нурбол Мухаметжан on 23.05.2024.
//

import Foundation

class PhotoService {
    func fetchData(completion: @escaping ([Photo]) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: urlString) else {
            print("DEBUG: Error in url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                print("DEBUG: error in datatask session \(error)")
            }
            
            guard let data = data else {
                print("DEBUG: Error in data retrieval")
                return
            }
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                DispatchQueue.main.async {
                    completion(photos)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
    
    
    func fetchPhotos(page:Int, completion: @escaping ([Photo]) -> Void) {
        let limit = 20
        let start = (page - 1) * limit
        let urlString = "https://jsonplaceholder.typicode.com/photos?_start=\(start)&_limit=\(limit)"
        guard let url = URL(string: urlString) else {
            print("DEBUG: Error in url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                print("DEBUG: error in datatask session \(error)")
            }
            
            guard let data = data else {
                print("DEBUG: Error in data retrieval")
                return
            }
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                DispatchQueue.main.async {
                    completion(photos)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}

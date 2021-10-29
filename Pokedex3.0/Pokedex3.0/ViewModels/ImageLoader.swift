//
//  ImageLoader.swift
//  Pokedex3.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI

class ImageLoader {
    private var dataTasks = [URLSessionDataTask]()
    let baseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    let ext = ".png"
    func loadImage(for pokemon: Pokemon, completion: @escaping (Image?) -> Void) {
        let url = "\(baseUrl)\(pokemon.id)\(ext)"
        
        guard let imgurl = URL(string: url) else {
            print("failed to create URL")
            completion(nil)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: imgurl) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
            let imgData = data else {
                print("unknown APIerror")
                completion(nil)
                return
            }
            
            if (20...299).contains(response.statusCode) {
                guard let uiImage = UIImage(data: imgData) else {
                    print("failed to conver to UIIMage")
                    completion(nil)
                    return
                }
                
                let image = Image(uiImage: uiImage)
                completion(image)
            } else {
                print("wrong response status code")
                completion(nil)
            }
        }
        
        dataTasks.append(dataTask)
        dataTask.resume()
    }
    
    func reset() {
        dataTasks.forEach { $0.cancel() }
        dataTasks.removeAll()
    }
}

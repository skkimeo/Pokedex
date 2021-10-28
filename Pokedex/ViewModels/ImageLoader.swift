//
//  ImageLoader.swift
//  Pokedex
//
//  Created by sun on 2021/10/28.
//

import SwiftUI

class ImageLoader {
    private var dataTasks = [URLSessionDataTask]()
    
    
    func loadImage(for pokemon: Pokemon, completion: @escaping (Image?) -> Void) {
        let imgUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.id).png"
        print(imgUrl)
        print("end")
        guard let imgUrl = URL(string: imgUrl)  else {
            completion(nil)
            return
        }
        
        // on success create new dataTask to actually fetch the image
        
        let dataTask = URLSession.shared.dataTask(with: imgUrl) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data, let uiImage = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            let image = Image(uiImage: uiImage)
            print(type(of: image))
            completion(image)
        }
        print("image uploaded")
        dataTasks.append(dataTask)
        dataTask.resume()
    }
    
    func reset() {
        dataTasks.forEach { $0.cancel() }
        dataTasks.removeAll()
        
    }
}

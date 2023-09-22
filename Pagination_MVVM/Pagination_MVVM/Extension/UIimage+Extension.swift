//
//  UIimage+Extension.swift
//  Pagination_MVVM
//
//  Created by PHN MAC 1 on 22/09/23.
//

import UIKit

extension UIImageView{
    func setImage(strURL: String){
        
        if let imageUrl = URL(string: strURL) {
            // Create a URLSessionDataTask to download the image data.
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if error != nil {
                    print("Error downloading image: \(error!.localizedDescription)")
                    return
                }
                
                if let imageData = data {
                    if let image = UIImage(data: imageData) {
                        // Update the UI on the main thread to display the downloaded image.
                        DispatchQueue.main.async {
                            self.image = image
                        }
                        
                        // Now you can perform any image processing you need on 'image'.
                        // For example, you can apply filters, crop, or analyze it using Core ML.
                    } else {
                        print("Failed to create UIImage from data")
                    }
                } else {
                    print("No data received")
                }
            }.resume()
        } else {
            print("Invalid URL")
        }
    }
}


import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String) {
        
//        guard let originUrl = Recipe.foodImage else {
//            return
//        }
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

import UIKit
import Kingfisher

extension UIImageView {
    func loadFrom(URLAddress: String) {
        
        guard let url = URL(string: URLAddress) else {
            return
        }
        kf.setImage(with: url)
        
        DispatchQueue.global(qos: .background).async {
            if let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async { [weak self] in
                    if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                    }
                }
            }
        }
    }
}

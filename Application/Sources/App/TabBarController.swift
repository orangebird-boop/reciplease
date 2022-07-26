import UIKit

class TabBarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        tabBar.tintColor = .label
        
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(image: .mglass), tag: 1)
        
        let favouritesViewController = FavoritesViewController(coder: <#NSCoder#>)
        favouritesViewController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(image: .star), tag: 2)
            
        setViewControllers([
           UINavigationController(rootViewController: searchViewController),
           UINavigationController(rootViewController: favouritesViewController ?? <#default value#>)],
                           animated: true)
    }
}

extension UIImage {
    convenience init?(image: SystemImage) {
        self.init(systemName: image.rawValue)
    }
}

enum SystemImage: String {
    case star
    case mglass = "magnifyingglass"
}

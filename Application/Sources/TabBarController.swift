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
        
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let favouritesVC = FavouritesViewController()
        favouritesVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star"), tag: 2)
            
        setViewControllers([
           UINavigationController(rootViewController: searchVC),
           UINavigationController(rootViewController: favouritesVC)],
                           animated: true)
    }
}

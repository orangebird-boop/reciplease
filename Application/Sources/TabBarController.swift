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
        
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let favouritesViewController = FavouritesViewController()
        favouritesViewController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star"), tag: 2)
            
        setViewControllers([
           UINavigationController(rootViewController: searchViewController),
           UINavigationController(rootViewController: favouritesViewController)],
                           animated: true)
    }
}

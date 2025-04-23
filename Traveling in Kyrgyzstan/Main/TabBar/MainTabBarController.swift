import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .systemGreen
        tabBar.backgroundColor = .systemBackground
    }
    
    private func setupViewControllers() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let exploreVC = UINavigationController(rootViewController: ExploreViewController())
        exploreVC.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "map"), tag: 1)
        
        let guidesVC = UINavigationController(rootViewController: GuidesViewController())
        guidesVC.tabBarItem = UITabBarItem(title: "Guides", image: UIImage(systemName: "book"), tag: 2)
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        viewControllers = [homeVC, exploreVC, guidesVC, profileVC]
    }
} 
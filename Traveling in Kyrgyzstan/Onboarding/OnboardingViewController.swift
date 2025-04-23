import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    private let pageViewController: UIPageViewController = {
        let controller = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: [.interPageSpacing: 0]
        )
        return controller
    }()
    
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 3
        control.currentPage = 0
        control.currentPageIndicatorTintColor = .white
        control.pageIndicatorTintColor = .white.withAlphaComponent(0.5)
        return control
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        return button
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LET'S BEGIN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.isHidden = true
        return button
    }()
    
    private lazy var pages: [OnboardingPageViewController] = {
        let page1 = OnboardingPageViewController(
            image: UIImage(named: "first")!,
            title: "KYRGYZSTAN\nTRAVEL GUIDE",
            subtitle: "Welcome to Kyrgyzstan! This app will help you discover the best places, plan your journey, and experience the authentic beauty of our country. Your perfect travel companion.",
            verticalText: ""
        )
        
        let page2 = OnboardingPageViewController(
            image: UIImage(named: "second")!,
            title: "NATURAL\nWONDERS",
            subtitle: "From pristine mountain lakes to vast steppes, discover Kyrgyzstan's breathtaking landscapes. Get detailed information about national parks and hiking trails.",
            verticalText: "NATURE"
        )
        
        let page3 = OnboardingPageViewController(
            image: UIImage(named: "third")!,
            title: "NOMADIC\nCULTURE",
            subtitle: "Experience the rich nomadic heritage, traditional customs, and authentic hospitality. Find local events, festivals and cultural activities.",
            verticalText: "CULTURE"
        )
        
        return [page1, page2, page3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scrollView = pageViewController.view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
            scrollView.bounces = false
            scrollView.alwaysBounceVertical = false
            scrollView.alwaysBounceHorizontal = false
        }
        
        setupPageViewController()
        setupUI()
        setupActions()
    }
    
    private func setupPageViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: true)
        
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupUI() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(startButton)
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(pageControl)
            make.right.equalToSuperview().offset(-20)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerY.equalTo(pageControl)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    private func setupActions() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        guard let currentViewController = pageViewController.viewControllers?.first,
              let currentIndex = pages.firstIndex(of: currentViewController as! OnboardingPageViewController),
              currentIndex < pages.count - 1 else {
            return
        }
        
        pageViewController.setViewControllers(
            [pages[currentIndex + 1]],
            direction: .forward,
            animated: true
        )
        
        pageControl.currentPage = currentIndex + 1
        updateButtons(for: currentIndex + 1)
    }
    
    @objc private func startButtonTapped() {
        let mainTabBar = MainTabBarController()
        mainTabBar.modalPresentationStyle = .fullScreen
        present(mainTabBar, animated: true)
    }
    
    private func updateButtons(for page: Int) {
        nextButton.isHidden = page == pages.count - 1
        startButton.isHidden = page != pages.count - 1
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? OnboardingPageViewController,
              let currentIndex = pages.firstIndex(of: currentViewController),
              currentIndex > 0 else {
            return nil
        }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? OnboardingPageViewController,
              let currentIndex = pages.firstIndex(of: currentViewController),
              currentIndex < pages.count - 1 else {
            return nil
        }
        return pages[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
           let currentViewController = pageViewController.viewControllers?.first as? OnboardingPageViewController,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
            updateButtons(for: currentIndex)
        }
    }
} 

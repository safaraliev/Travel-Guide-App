import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private let contentView = UIView()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Kyrgyzstan"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let categoriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 100)
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.contentInsetAdjustmentBehavior = .always
        return collection
    }()
    
    private let placesLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular Places"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let placesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let categories: [(title: String, icon: String, color: UIColor)] = [
        ("Nature", "leaf.fill", .systemGreen),
        ("Culture", "building.columns.fill", .systemOrange),
        ("Historical", "clock.fill", .systemBrown),
        ("Entertainment", "star.fill", .systemPurple)
    ]
    
    private var places: [Place] {
        PlacesManager.shared.places
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionViews()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Home"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [welcomeLabel, categoriesLabel, categoriesCollectionView, placesLabel, placesCollectionView].forEach {
            contentView.addSubview($0)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        categoriesLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoriesLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        placesLabel.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        placesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(placesLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(UIScreen.main.bounds.height * 0.6) // Примерная высота для прокрутки
        }
    }
    
    private func setupCollectionViews() {
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        
        placesCollectionView.delegate = self
        placesCollectionView.dataSource = self
        placesCollectionView.register(FeaturedPlaceCell.self, forCellWithReuseIdentifier: FeaturedPlaceCell.identifier)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return categories.count
        } else {
            return places.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            let category = categories[indexPath.item]
            cell.configure(title: category.title, icon: category.icon, color: category.color)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaceCell.identifier, for: indexPath) as! FeaturedPlaceCell
            cell.configure(with: places[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollectionView {
            let category = categories[indexPath.item]
            print("Selected category: \(category.title)")
            // TODO: Show places filtered by category
        } else {
            let place = places[indexPath.item]
            let detailVC = PlaceDetailViewController(place: place)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
} 
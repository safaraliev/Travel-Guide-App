import UIKit
import SnapKit

class OnboardingPageViewController: UIViewController {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let verticalTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 64, weight: .bold)
        label.transform = CGAffineTransform(rotationAngle: .pi/2)
        return label
    }()
    
    
    init(image: UIImage, title: String, subtitle: String, verticalText: String) {
        super.init(nibName: nil, bundle: nil)
        backgroundImageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
        verticalTextLabel.text = verticalText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(backgroundImageView)
        view.addSubview(overlayView)
        
        [titleLabel, subtitleLabel, verticalTextLabel].forEach {
            view.addSubview($0)
        }
        
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-100)
            make.top.equalToSuperview().offset(100)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-100)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        verticalTextLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(60)
            make.centerY.equalToSuperview()
        }
    }
} 

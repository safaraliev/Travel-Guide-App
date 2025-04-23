import UIKit
import SnapKit
import WebKit

class GuidesViewController: UIViewController {
    
    private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebsite()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Travel Guide"
        
        view.addSubview(webView)
        view.addSubview(loadingIndicator)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        webView.navigationDelegate = self
    }
    
    private func loadWebsite() {
        loadingIndicator.startAnimating()
        
        guard let url = URL(string: "https://www.tripadvisor.com/Tourism-g293947-Kyrgyzstan-Vacations.html") else {
            showError()
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func showError() {
        let alert = UIAlertController(
            title: "Error",
            message: "Unable to load the travel guide. Please check your internet connection and try again.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.loadWebsite()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
}

extension GuidesViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingIndicator.stopAnimating()
        showError()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loadingIndicator.stopAnimating()
        showError()
    }
} 
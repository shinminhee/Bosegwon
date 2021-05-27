//
//  KakaoAddressViewController.swift
//  Bosegwon
//
//  Created by 신민희 on 2021/05/27.
//

import MapKit
import NMapsMap
import UIKit
import WebKit


class KakaoAddressViewController: UIViewController {
    
    // MARK: - Properties
    var webView: WKWebView?
    let indicator = UIActivityIndicatorView(style: .medium)
    var address = ""
    let contentController = WKUserContentController()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .white
        setAttributes()
        setContraints()
    }
    
    private func setAttributes() {
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        
        webView = WKWebView(frame: .zero, configuration: configuration)
        self.webView?.navigationDelegate = self
        
        guard let url = URL(string: "https://shinminhee.github.io/Bosegwon/"),
              let webView = webView
        else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        indicator.startAnimating()
    }
    
    private func setContraints() {
        guard let webView = webView else { return }
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            indicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
        ])
    }
}

extension KakaoAddressViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let data = message.body as? [String: Any] {
            address = data["roadAddress"] as? String ?? ""
        }
        guard let tabBarController = presentingViewController as? UITabBarController else { return }
        guard let previousVC = tabBarController.viewControllers?.first as? ViewController else { return }
        previousVC.searchLabel.text = address
        self.dismiss(animated: true) {
            let address = CLGeocoder()
            var lat: Double = 0
            var lng: Double = 0
            address.geocodeAddressString(previousVC.searchLabel.text ?? "", completionHandler: { placemarks, error in
                guard let placemark = placemarks?.first!, let location = placemark.location else { return }
                print(location)
               lat = location.coordinate.latitude
               lng = location.coordinate.longitude
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: lat, lng: lng)
                marker.iconImage = NMF_MARKER_IMAGE_BLACK
                marker.iconTintColor = UIColor.red
                marker.width = 30
                marker.height = 40
                marker.mapView = previousVC.naverMapView.mapView
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
                cameraUpdate.animation = .fly
                cameraUpdate.animationDuration = 1
                previousVC.naverMapView.mapView.moveCamera(cameraUpdate)
                
            })
        }
    }
}

extension KakaoAddressViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}

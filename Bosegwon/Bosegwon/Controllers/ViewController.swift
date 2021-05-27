//
//  ViewController.swift
//  Bosegwon
//
//  Created by 신민희 on 2021/05/27.
//

import NMapsMap
import SnapKit
import UIKit

class ViewController: UIViewController {
    let naverMapView = NMFNaverMapView()
    let locationManager = CLLocationManager()
    let searchBar = UIView()
    let searchLabel = UILabel()
    let searchImage = UIImageView()
    let searchBackImage = UIImageView()
    let locationButton = UIButton()
    var currentLatitude: Double = 0
    var currentLongtitude: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
}
extension ViewController {
    
    @objc
    func tapedLocationButton(_ sender: UIButton) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: currentLatitude, lng: currentLongtitude))
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        self.naverMapView.mapView.moveCamera(cameraUpdate)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLatitude = locations.last!.coordinate.latitude
        currentLongtitude = locations.last!.coordinate.longitude
    }
}

extension ViewController {
    
    final private func setUI() {
        setLocationManager()
        setLayout()
        setBasic()
    }
    func setLocationManager() {
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization() //권한 요청
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = kCLDistanceFilterNone
    locationManager.startUpdatingLocation()
    }
    final private func setLayout() {
        view.addSubview(naverMapView)
        naverMapView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        [searchBar, searchImage, searchLabel, searchBackImage].forEach {
            view.addSubview($0)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top).inset(60)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        searchImage.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(searchBar).inset(10)
            $0.width.equalTo(30)
        }
        searchLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(searchImage)
            $0.leading.equalTo(searchImage.snp.trailing).offset(20)
            $0.width.equalTo(200)
        }
        searchBackImage.snp.makeConstraints {
            $0.top.trailing.bottom.equalTo(searchBar).inset(10)
            $0.width.equalTo(30)
        }
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(110)
            $0.trailing.equalTo(searchBar.snp.trailing)
            $0.height.width.equalTo(60)
        }

    }
    final private func setBasic() {
        
        naverMapView.mapView.positionMode = .direction
        naverMapView.mapView.positionMode = .compass
        
        searchBar.backgroundColor = .white
        searchBar.layer.cornerRadius = 15
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 0.2
        searchBar.layer.shadowColor = UIColor.gray.cgColor // 색깔
        searchBar.layer.masksToBounds = false
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 5)
        searchBar.layer.shadowRadius = 5
        searchBar.layer.shadowOpacity = 0.3
        
        searchLabel.text = "위치를 찾아주세요."
        searchLabel.font = UIFont.boldSystemFont(ofSize: 16)
        searchLabel.textColor = .systemGray
        searchImage.image = UIImage(systemName: "magnifyingglass")
        searchImage.tintColor = UIColor.appColor(.mainColor)

        searchBackImage.image = UIImage(systemName: "list.bullet")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        
        locationButton.backgroundColor = UIColor.appColor(.mainColor)
        locationButton.layer.cornerRadius = 30
        locationButton.setImage(UIImage(systemName: "scope"), for: .normal)
        locationButton.tintColor = UIColor.white
        locationButton.addTarget(self, action: #selector(tapedLocationButton(_:)), for: .touchUpInside)

    }
}

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
    let searchBar = ColorView()
    let searchLabel = UILabel()
    let searchImage = UIImageView()
    let searchBackImage = UIImageView()
    let locationButton = UIButton()
    var currentLatitude: Double = 0
    var currentLongtitude: Double = 0
    let genderView = UIView()
    let maleView = ColorView()
    let femaleView = ColorView()
    let unisexView = ColorView()
    let maleLabel = UILabel()
    let femaleLabel = UILabel()
    let unisexLabel = UILabel()
    
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
    @objc
    func searchBarTaped(_ sender: UITapGestureRecognizer) {
        let kakaoVC = KakaoAddressViewController()
        self.present(kakaoVC, animated: true, completion: nil)
        
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
        setGenderView()
    }
    final private func setLocationManager() {
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
            $0.leading.trailing.equalToSuperview().inset(20)
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
            $0.height.width.equalTo(50)
        }

    }
    final private func setBasic() {
        
        naverMapView.mapView.positionMode = .direction
        naverMapView.mapView.positionMode = .compass
        
        searchBar.backgroundColor = .white
        searchBar.layer.cornerRadius = 15
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 0.2
        let searchBarTaped = UITapGestureRecognizer(target: self, action: #selector(searchBarTaped(_:)))
        searchBarTaped.numberOfTouchesRequired = 1
        searchBarTaped.numberOfTapsRequired = 1
        searchBar.addGestureRecognizer(searchBarTaped)
        searchBar.isUserInteractionEnabled = true
        
        
        searchLabel.text = "위치를 찾아주세요."
        searchLabel.font = UIFont.boldSystemFont(ofSize: 15)
        searchLabel.textColor = .systemGray
        searchImage.image = UIImage(systemName: "magnifyingglass")
        searchImage.tintColor = UIColor.appColor(.mainColor)

        searchBackImage.image = UIImage(systemName: "list.bullet")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        
        locationButton.backgroundColor = UIColor.appColor(.mainColor)
        locationButton.layer.cornerRadius = 25
        locationButton.setImage(UIImage(systemName: "scope"), for: .normal)
        locationButton.tintColor = UIColor.white
        locationButton.addTarget(self, action: #selector(tapedLocationButton(_:)), for: .touchUpInside)
    }
    final private func setGenderView() {
        [genderView, maleView, femaleView, unisexView, maleLabel, femaleLabel, unisexLabel].forEach {
            view.addSubview($0)
        }
        genderView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(5)
            $0.trailing.equalTo(searchBar.snp.trailing)
            $0.height.equalTo(40)
            $0.width.equalTo(190)
        }
        maleView.snp.makeConstraints {
            $0.leading.equalTo(genderView).inset(10)
            $0.top.bottom.equalTo(genderView).inset(15)
            $0.width.equalTo(10)
        }
        maleLabel.snp.makeConstraints {
            $0.leading.equalTo(maleView.snp.trailing).offset(5)
            $0.top.bottom.equalTo(maleView)
            $0.width.equalTo(30)
        }
        femaleView.snp.makeConstraints {
            $0.leading.equalTo(maleLabel.snp.trailing).offset(5)
            $0.top.bottom.equalTo(maleView)
            $0.width.equalTo(10)
        }
        femaleLabel.snp.makeConstraints {
            $0.leading.equalTo(femaleView.snp.trailing).offset(5)
            $0.top.bottom.equalTo(maleView)
            $0.width.equalTo(45)
        }
        unisexView.snp.makeConstraints {
            $0.leading.equalTo(femaleLabel.snp.trailing).offset(5)
            $0.top.bottom.equalTo(maleView)
            $0.width.equalTo(10)
        }
        unisexLabel.snp.makeConstraints {
            $0.leading.equalTo(unisexView.snp.trailing).offset(5)
            $0.top.bottom.equalTo(maleView)
            $0.width.equalTo(45)
        }
        
        genderView.backgroundColor = .clear
        maleView.backgroundColor = .blue
        femaleView.backgroundColor = .red
        unisexView.backgroundColor = .black
        
        maleLabel.text = "Male"
        maleLabel.font = UIFont.systemFont(ofSize: 13)
        femaleLabel.text = "Female"
        femaleLabel.font = UIFont.systemFont(ofSize: 13)
        unisexLabel.text = "Unisex"
        unisexLabel.font = UIFont.systemFont(ofSize: 13)

    }
}

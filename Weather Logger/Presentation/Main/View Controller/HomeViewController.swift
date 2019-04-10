//
//  HomeViewController.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 07/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class HomeViewController: UIViewController {
    
    // MARK: - UI/Outlets
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var saveButton: UIButton! {
        willSet {
            newValue.layer.cornerRadius = 10
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        print("Saved")
    }
    
    
    // MARK: - Internal properties
    
    let viewModel = WeatherViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindRx()
    }
    
    private func bindRx() {
        viewModel.weather.asDriver().map { String(format: "%.f", $0) }.drive(degreeLabel.rx.text).disposed(by: disposeBag)
        viewModel.iconName.asDriver().map { UIImage(named: $0.rawValue) }.drive(weatherImageView.rx.image).disposed(by: disposeBag)
        Driver.combineLatest(viewModel.location.asDriver(), viewModel.country.asDriver()).flatMapLatest { location, country in
            return Driver.just("\(location), \(country)")
        }.drive(cityLabel.rx.text).disposed(by: disposeBag)
        viewModel.weatherDescription.asDriver().drive(weatherCondition.rx.text).disposed(by: disposeBag)
    }
    
}
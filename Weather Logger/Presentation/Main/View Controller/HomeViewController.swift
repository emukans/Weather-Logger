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
    
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    let viewModel = WeatherViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindRx()
    }
    
    private func bindRx() {
        viewModel.weather.asDriver().map { String(format: "%.f", $0) }.drive(degreeLabel.rx.text).disposed(by: disposeBag)
        viewModel.location.asDriver().drive(cityLabel.rx.text).disposed(by: disposeBag)
    }
    
}

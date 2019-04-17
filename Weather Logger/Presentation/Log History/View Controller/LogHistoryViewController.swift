//
//  LogHistoryViewController.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 08/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class LogHistoryViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Types
    
    typealias dataSourceModelClass = SectionModel<String, Weather>
    
    
    // MARK: - UI/Outlets
    
    @IBOutlet weak var logHistoryTableView: UITableView!
    
    
    // MARK: - Internal properties
    
    lazy var viewModel: LogHistoryViewModel = {
        return LogHistoryViewModel()
    }()
    var dataSource: RxTableViewSectionedReloadDataSource<dataSourceModelClass>!
    let disposeBag = DisposeBag()
    
    
    // MARK: - Object life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configueTableView()
        configureDataSource()
    }
    
    func configueTableView() {
        logHistoryTableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.viewIdentifier)
        logHistoryTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func configureDataSource() {
        dataSource = RxTableViewSectionedReloadDataSource<dataSourceModelClass>(
            configureCell: { (_, colectionView, indexPath, model) -> UITableViewCell in
                let cell = colectionView.dequeueReusableCell(withIdentifier: WeatherCell.viewIdentifier, for: indexPath) as! WeatherCell
                cell.configure(withModel: model)
                cell.selectionStyle = .none
                
                return cell
        })
        dataSource.canEditRowAtIndexPath = { dataSource, indexPath  in
            return true
        }
        
        viewModel.logHistoryData.asDriver().drive(logHistoryTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let responding = UIContextualAction(style: .destructive, title: nil, handler: { [weak self] (_, _, success: (Bool) -> Void) in
            guard let strongSelf = self else { return }
            
            success(true)
            strongSelf.viewModel.removeItem(at: indexPath)
        })

        responding.backgroundColor = UIColor.WeatherLogger.defaultBackgroundColor
        responding.image = UIImage(named: "icon-bin")

        return UISwipeActionsConfiguration(actions: [responding])
    }

}

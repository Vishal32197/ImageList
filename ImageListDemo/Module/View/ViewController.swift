//
//  ViewController.swift
//  ImageListDemo
//
//  Created by Bishal Ram on 15/05/24.
//

import UIKit
import Stevia

class ViewController: UIViewController {
    
    private lazy var listTableView: UITableView = {
          let tableview = UITableView()
          tableview.register(ListTableViewCell.self, forCellReuseIdentifier: "\(ListTableViewCell.self)")
          tableview.estimatedRowHeight = 42.0
          tableview.separatorStyle = .none
          tableview.dataSource = self
          tableview.rowHeight = UITableView.automaticDimension
          return tableview
      }()

    private var viewModel: ViewModelProtocol
    
    // MARK: // Initialization
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
        addBindings()
        viewModel.fetchImages()
    }
    
    private func setupViewLayout() {
        view.backgroundColor = .white
        view.subviews {
            listTableView
        }
        
        listTableView.fillContainer()
    }
    
    private func addBindings() {
        viewModel.onDataUpdate = { result in
            switch result {
            case .success(let status):
                if status {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.listTableView.reloadData()
                    }
                }
            case .failure(_):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    // Show error
                }
            }
        }
      }
  }

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.imageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "\(ListTableViewCell.self)", for: indexPath) as! ListTableViewCell
        cell.setupContent(imageURL: viewModel.imageList[indexPath.row].url.asURL()!,
                          placeHolderURL: viewModel.imageList[indexPath.row].thumbnailUrl.asURL()!)
        return cell
    }
}



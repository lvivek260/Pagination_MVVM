//
//  ViewController.swift
//  Pagination_MVVM
//
//  Created by PHN MAC 1 on 22/09/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photosTableView: UITableView!
    let viewModel = PhotosViewModel()
    var loadingFooterView: LoadingFooterView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiConfiguration()
        observeEvent()
        fetchData()
    }


}

// MARK: - Configurations
extension ViewController{
    private func uiConfiguration(){
        photosTableView.delegate = self
        photosTableView.dataSource = self
        photosTableView.rowHeight = 160
        photosTableView.register(PhotosCell.nib, forCellReuseIdentifier: PhotosCell.id)
        self.loadingFooterView = LoadingFooterView(frame: CGRect(x: 0, y: 0, width: photosTableView.frame.width, height: 44))
        photosTableView.tableFooterView = loadingFooterView
    }
    
    private func fetchData(){
        viewModel.fetchData()
    }
    
    private func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch event{
                case .startLoading:
                    break
                    
                case .stopLoading:
                    self.loadingFooterView?.stopAnimating()
                    break
                    
                case .reloadData:
                    print("Total Data:-",self.viewModel.data.count)
                    self.photosTableView.reloadData()
                    break
                    
                case .error(let err):
                    print(err)
                    break
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = photosTableView.dequeueReusableCell(withIdentifier: PhotosCell.id, for: indexPath) as? PhotosCell else { return UITableViewCell() }
        cell.data = self.viewModel.data[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.data.count - 1 {
            loadingFooterView?.startAnimating()
            viewModel.fetchData()
        }
    }
}

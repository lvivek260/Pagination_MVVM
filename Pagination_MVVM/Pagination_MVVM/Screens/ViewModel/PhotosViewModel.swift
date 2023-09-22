//
//  PhotosViewModel.swift
//  Pagination_MVVM
//
//  Created by PHN MAC 1 on 22/09/23.
//

import Foundation

final class PhotosViewModel{
      var currentPage = 1
      let pageSize = 10
      var data = [PhotosModel]()
      var eventHandler : ((_ event: Event) -> Void)?
      
      func fetchData() {
          guard let eventHandler else{return}
          eventHandler(.startLoading)
          YourAPIService.fetchData(page: currentPage, pageSize: pageSize) { [weak self] result in
              eventHandler(.stopLoading)
              switch result {
              case .success(let newData):
                  self?.data.append(contentsOf: newData)
                  self?.currentPage += 1
                  eventHandler(.reloadData)
              case .failure(let error):
                  // Handle the error
                  print("Error fetching data: \(error.localizedDescription)")
                  eventHandler(.error(error))
              }
          }
      }
}

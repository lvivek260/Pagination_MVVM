//
//  FootView.swift
//  Pagination_MVVM
//
//  Created by PHN MAC 1 on 22/09/23.
//

import UIKit

class LoadingFooterView: UIView {
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        activityIndicator.center = center
        addSubview(activityIndicator)
    }

    func startAnimating() {
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}

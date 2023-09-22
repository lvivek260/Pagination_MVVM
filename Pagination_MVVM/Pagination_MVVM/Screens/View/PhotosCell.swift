//
//  PhotosCell.swift
//  Pagination_MVVM
//
//  Created by PHN MAC 1 on 22/09/23.
//

import UIKit

class PhotosCell: UITableViewCell {

    @IBOutlet weak var photosImgView: UIImageView!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    var data: PhotosModel? {
        didSet{
            photosImgView.setImage(strURL: data?.thumbnailUrl ?? "")
            lblId.text = String(data?.id ?? 0)
            lblTitle.text = data?.title ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

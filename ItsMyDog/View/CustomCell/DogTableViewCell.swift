//
//  DogTableViewCell.swift
//  ItsMyDog
//
//  Created by Yves Charpentier on 01/09/2023.
//

import UIKit
import SDWebImage

class DogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dogImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: String) {
        dogImageView.sd_setImage(with: URL(string: image))
    }
}

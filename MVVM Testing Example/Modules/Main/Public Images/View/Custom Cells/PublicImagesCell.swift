//
//  PublicImagesCell.swift
//  MVVM Unit Testing Example
//
//  Created by Loay Ashraf on 10/03/2022.
//

import UIKit

class PublicImagesCell: TableViewCell, InterfaceBuilderTableViewCell {

    override class var reuseIdentifier: String { return String(describing: PublicImagesCell.self) }
    override class var nib: UINib { return UINib(nibName: String(describing: PublicImagesCell.self), bundle: nil) }
    
    @IBOutlet weak var publicImageView: SFImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSkeletonable = true
        contentView.isSkeletonable = true
        publicImageView.isSkeletonable = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        publicImageView.image = nil
    }
    
}

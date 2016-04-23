//
//  LibroTableViewCell.swift
//  BibliotecaISBN
//
//  Created by Jorge Andres Moreno Castiblanco on 22/04/16.
//  Copyright © 2016 eworld. All rights reserved.
//

import UIKit

class LibroTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    
    @IBOutlet weak var portadaCelda: UIImageView!
    @IBOutlet weak var tituloCelda: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

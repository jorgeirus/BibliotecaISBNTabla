//
//  vistaDetalle.swift
//  BibliotecaISBN
//
//  Created by Jorge Andres Moreno Castiblanco on 15/04/16.
//  Copyright © 2016 eworld. All rights reserved.
//

import UIKit

class vistaDetalle: UIViewController {
    
    
    var tituloLibro = ""

    @IBOutlet weak var Titulo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Titulo.text = tituloLibro

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

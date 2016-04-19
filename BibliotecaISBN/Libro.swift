//
//  Libro.swift
//  BibliotecaISBN
//
//  Created by Jorge Andres Moreno Castiblanco on 5/04/16.
//  Copyright © 2016 eworld. All rights reserved.
//

import UIKit


class Libro: UIViewController {
    
    
    
    @IBOutlet weak var tituloLibro: UILabel!
    @IBOutlet weak var nombreAutores: UILabel!
    @IBOutlet weak var imagenPortada: UIImageView!
    @IBOutlet weak var noImagen: UILabel!
    @IBAction func Busqueda(sender: UITextField) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "datosBusqueda" {
            if let destination = segue.destinationViewController as? TVC {
                destination.isbn = sender!.text
                print(sender!.text!)
            }
        }
        
    }
    

}

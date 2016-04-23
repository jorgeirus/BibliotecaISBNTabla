//
//  Libro.swift
//  BibliotecaISBN
//
//  Created by Jorge Andres Moreno Castiblanco on 21/04/16.
//  Copyright © 2016 eworld. All rights reserved.
//

import Foundation
import UIKit

class Libro {
    let nombre: String
    let autores: String
    let imagen: UIImage
    
    init(nombre: String, autores:String, imagen:UIImage){
        self.nombre = nombre
        self.autores = autores
        self.imagen = imagen
    }
    
}

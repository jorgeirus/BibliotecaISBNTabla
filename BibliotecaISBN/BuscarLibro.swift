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
        busquedaLibro(sender.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func busquedaLibro(isbn: String){
        
        
        let ISBN:String = isbn
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let url = NSURL(string: urls + isbn)
        let datos = NSData(contentsOfURL: url!)
        let validar = NSString(data: datos!, encoding:NSUTF8StringEncoding)
        
        
        
        if validar == "{}"{
            let alerta = UIAlertController(title: "ISBN incorrecto",
                                           message: "No encontramos el libro",
                                           preferredStyle: UIAlertControllerStyle.Alert)
            
            let accion2 = UIAlertAction(title: "OK",
                                        style: UIAlertActionStyle.Cancel)
            {
                _ in
            }
            alerta.addAction(accion2)
            self.presentViewController(alerta, animated: true, completion: nil)
            
            
            
        }else{
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                let isbn1 = json["ISBN:\(ISBN)"] as! NSDictionary!
                let titulo = isbn1["title"] as! NSString as String
                tituloLibro.text = titulo
                var nombresAutores: String = ""
                if let autores =  isbn1["authors"] as? NSArray{
                    for autor in autores{
                        if let nombre = autor["name"] as? String{
                            if (nombresAutores != ""){
                                nombresAutores = nombresAutores + ", "
                            }
                            nombresAutores = nombresAutores + (nombre)
                        }
                    }
                    
                }else{
                    nombreAutores.text = "no hay autor"
                }
                nombreAutores.text = nombresAutores
                if let portada = isbn1["cover"] as! NSDictionary!{
                    let img_urls = portada["medium"] as! String
                    let img_url = NSURL(string: img_urls)
                    let img_datos = NSData(contentsOfURL: img_url!)
                    if let imagen = UIImage(data: img_datos!){
                        imagenPortada.image = imagen
                    }
                }else{
                    noImagen.text = "No tiene Portada"
                }
                
            }
            catch _{
                print("Los datos en JSON son incorrectos")
            }
            
        }
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

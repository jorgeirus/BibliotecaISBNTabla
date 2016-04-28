//
//  Libro.swift
//  BibliotecaISBN
//
//  Created by Jorge Andres Moreno Castiblanco on 5/04/16.
//  Copyright © 2016 eworld. All rights reserved.
//

import UIKit


class BuscarLibro: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var tituloLibro: UILabel!
    @IBOutlet weak var nombreAutores: UILabel!
    @IBOutlet weak var portada: UIImageView!
    @IBOutlet weak var noImagen: UILabel!
    @IBOutlet weak var save: UIBarButtonItem!
    
    var libro:Libro?
    
    
    @IBAction func BuscarLibro(sender: AnyObject) {
        
        if sender.text != ""{
            busquedaLibro(sender.text!)
        }else{
            let alerta = UIAlertController(title: "Por favor digite un ISBN",
                                           message: "El campo no puede estar vacio",
                                           preferredStyle: UIAlertControllerStyle.Alert)
            
            let accion2 = UIAlertAction(title: "OK",
                                        style: UIAlertActionStyle.Cancel)
            {
                _ in
            }
            alerta.addAction(accion2)
            self.presentViewController(alerta, animated: true, completion: nil)
        }
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
        
        if datos != nil{
            
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
                var titulo: String = ""
                var nombresAutores: String = ""
                var imagenPortada = UIImage()
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                let isbn1 = json["ISBN:\(ISBN)"] as! NSDictionary!
                titulo = isbn1["title"] as! NSString as String
                tituloLibro.text = titulo
                if let autores =  isbn1["authors"] as? NSArray{
                    for autor in autores{
                        if let nombre = autor["name"] as? String{
                            if (nombresAutores != ""){
                                nombresAutores = nombresAutores + ", "
                            }
                            nombresAutores = nombresAutores + (nombre)
                            nombreAutores.text = nombresAutores
                        }
                    }
                    
                }else{
                    nombreAutores.text = "no hay autor"
                }
                if let img = isbn1["cover"] as! NSDictionary!{
                    let img_urls = img["medium"] as! String
                    let img_url = NSURL(string: img_urls)
                    if let img_datos = NSData(contentsOfURL: img_url!){
                        imagenPortada = UIImage(data: img_datos)!
                        portada.image = imagenPortada
                    }else{
                        portada.image = UIImage(named: "DefoultImage")
                    }

                }
                
                libro = Libro(nombre: titulo, autores: nombresAutores, imagen: imagenPortada)
                print(libro?.nombre)
                print(libro?.autores)
            
            }catch _{
                print("Los datos en JSON son incorrectos")
            }
        }
        }else{
            let alerta = UIAlertController(title: "Error: Sin Conexión",
                                           message: "Verifique si tiene conexión a internet",
                                           preferredStyle: UIAlertControllerStyle.Alert)
            
            let accion2 = UIAlertAction(title: "OK",
                                        style: UIAlertActionStyle.Cancel)
            {
                _ in
            }
            alerta.addAction(accion2)
            self.presentViewController(alerta, animated: true, completion: nil)

        }
    }
    
    

    @IBAction func Cancelar(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if save === sender{
            
            print("Libro Agregado")
            
            
        }
        
    }
    
}

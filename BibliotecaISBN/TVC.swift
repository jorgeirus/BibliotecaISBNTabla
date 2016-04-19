//
//  TVC.swift
//  BibliotecaISBN
//
//  Created by Jorge Andres Moreno Castiblanco on 4/04/16.
//  Copyright © 2016 eworld. All rights reserved.
//

import UIKit

class TVC: UITableViewController {
    
    var isbn:String = ""
    
    private var libros: Array<Array<String>> = Array<Array<String>>()
    
    var detalles = [Detalle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bibloteca.org"
        self.libros.append(["Libro1"])
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
                    var noAutor:String = "no"
                }
                var nombreAutores:String = nombresAutores
                if let portada = isbn1["cover"] as! NSDictionary!{
                    let img_urls = portada["medium"] as! String
                    let img_url = NSURL(string: img_urls)
                    let img_datos = NSData(contentsOfURL: img_url!)
                    if let imagen = UIImage(data: img_datos!){
                        
                    }
                }else{
                    var noImagen:String = "No tiene Portada"
                }
                detalles = [Detalle(titulo:titulo , autores: nombresAutores, imagen: "")]
            }
            catch _{
                print("Los datos en JSON son incorrectos")
            }
            
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.libros.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.libros[indexPath.row][0]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detalle"{
            if let destination = segue.destinationViewController as? vistaDetalle {
                
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRowAtIndexPath(path!)
                destination.tituloLibro = (cell?.textLabel?.text)!
            }
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}

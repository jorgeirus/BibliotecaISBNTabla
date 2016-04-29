//
//  TVC.swift
//  BibliotecaISBN
//
//  Created by Jorge Andres Moreno Castiblanco on 4/04/16.
//  Copyright © 2016 eworld. All rights reserved.
//

import UIKit
import CoreData

class TVC: UITableViewController {
    
    var libros: Array<Libro> = Array<Libro>()
    var contexto: NSManagedObjectContext? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bibloteca.org"
        self.contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let libroEntidad = NSEntityDescription.entityForName("Libro", inManagedObjectContext: self.contexto!)
        let peticion = libroEntidad?.managedObjectModel.fetchRequestTemplateForName("petLibros")
        do{
            let librosEntidades = try self.contexto?.executeFetchRequest(peticion!)
            for libro in librosEntidades!{
                let titulo = libro.valueForKey("titulo") as! String
                let autor = libro.valueForKey("autor") as! String
                var imagenPortada = UIImage()
                if libro.valueForKey("portada") != nil {
                    imagenPortada = UIImage(data: libro.valueForKey("portada") as! NSData)!
                }
                
                self.libros.append(Libro(nombre: titulo, autores: autor, imagen: imagenPortada))
            }
        }catch{}
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return libros.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let libro = libros[indexPath.row]
        cell.textLabel!.text = libro.nombre
        cell.imageView?.image = libro.imagen
        
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
            let sv = segue.destinationViewController as! vistaDetalle
            sv.libro = self.libros[(self.tableView.indexPathForSelectedRow?.row)!]
        }else if segue.identifier == "AddItem"{
            print("Agregar Libro")
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func agregarLibro(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as?
            BuscarLibro, libro = sourceViewController.libro{
            
                // Agrega un nuevo libro.
                let newIndexPath = NSIndexPath(forRow: libros.count, inSection: 0)
                libros.append(libro)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            
        }
    }


}

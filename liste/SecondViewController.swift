//
//  SecondViewController.swift
//  liste
//
//  Created by tp on 12/02/2020.
//  Copyright © 2020 tp. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Data
    
    /*var headlines = [
        Headline(id: 1, title: "Pomme", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque id ornare tortor, quis dictum enim. Morbi convallis tincidunt quam eget bibendum. Suspendisse malesuada maximus ante, at molestie massa fringilla id.", image: "Apple"),
        Headline(id: 2, title: "Banane", text: "Ut eget massa erat. Morbi mauris diam, vulputate at luctus non, finibus et diam. Morbi et felis a lacus pharetra blandit.", image: "Banana"),
        Headline(id: 3, title: "Melon", text: "Aliquam egestas ultricies dapibus. Nam molestie nunc in ipsum vehicula accumsan quis sit amet quam. Sed vel feugiat eros.", image: "Cantaloupe"),
        Headline(id: 4, title: "Abricot", text: "Nulla vitae elit libero, a pharetra augue. Donec ullamcorper nulla non metus auctor fringilla. Cras mattis consectetur purus sit amet fermentum. Sed posuere consectetur est at lobortis.", image: "Apricot"),
        ]*/
    
    var tasks = [Tache]()
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Cellules ajout2")
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! TableViewCell
        
        //let headline = headlines[indexPath.row]
        let headline = tasks[indexPath.row]
        cell.titleCell?.text = headline.nom
        cell.descriptionCell?.text = headline.descriptionM
        cell.imageCell?.image = UIImage(named: headline.image!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Changement Vue")
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DvC = Storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        tableView.deselectRow(at: indexPath, animated: true)
        
        DvC.imageCurrent = tasks[indexPath.row].image!
        DvC.titleCurrent = tasks[indexPath.row].nom!
        DvC.desriptionCurrent = tasks[indexPath.row].descriptionM!
        
        self.navigationController?.pushViewController(DvC, animated: true)
    }
    
    // Suppression d'une cellule
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Cellule supprimée")
            
            self.tasks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func creerNouvelleTache(_ nom: String, _ description: String, _ image: String) -> Tache{
        let tache = Tache(context: context)
        tache.nom = nom
        tache.descriptionM = description
        tache.image = image
        
        return tache;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nouvellePersonne = Personne(context: context)
        nouvellePersonne.nom = "Alice"
        nouvellePersonne.age = 25
        
        let autrePersonne = Personne(context: context)
        autrePersonne.nom = "Pierre"
        autrePersonne.age = 52
        
        let tache1 = creerNouvelleTache("Ma tache 1", "Ceci est une description improvisée écrite pour les besoins du test", "Banana")
        let tache2 = creerNouvelleTache("Ma tache 2", "ryyyyyyyy","Cantaloupe")
        let tache3 = creerNouvelleTache("Ma tache 3", "J'aime les abricots, ils sont tellement oranges et lumineux, ils me donnent envie de jongler avec.","Apricot")
        let tache4 = creerNouvelleTache("Ma tache 4", "rrrrrrrrrrrrrr","Apple")
        
        tasks.append(tache1)
        tasks.append(tache2)
        tasks.append(tache3)
        tasks.append(tache4)
        
        //let requete2 : NSFetchRequest<Tache> = Tache.fetchRequest()
        
        
        saveData()
        
        // Les données sont dans un fichier .sqlite qui se trouve dans :
        // /Users/<VOUS>/Library/Developer/CoreSimulator/Devices/FF7B856D-3118-4810-9A41-0F925C1FD30C/data/Containers/Data/Application/6AFB589E-9139-4CDA-AA80-75007AFC7829/Library/Application Support/<NOM_PROJET>.sqlite
        // Remplacer FF7B856D-3118-4810-9A41-0F925C1FD30C et 6AFB589E-9139-4CDA-AA80-75007AFC7829 par les valeurs adéquates
        // Si le répertoire Library n'est pas visible (car caché), vous pouvez le rendre visible en excétutant dans le terminal la commande :
        // chflags nohidden ~/Library
        
        // MARK: - Lecture de données (requêtes)
        
        //        let requete : NSFetchRequest<Personne> = Personne.fetchRequest() // Le type NSFetchRequest<Personne> doit être donné obligatoirement
        //        do {
        //            let resultas = try context.fetch(requete)
        //            print(resultas)
        //        } catch {
        //            print("Erreur lecture données : \(error)")
        //        }
        
        // MARK: - Lecture de données (requêtes avec conditions)
        
        let texte = "i"
        let requete : NSFetchRequest<Personne> = Personne.fetchRequest()
        requete.predicate = NSPredicate(format: "nom CONTAINS %@", texte)
        // CONTAINS[cd] pour ignorer la casse [c] et ignorer les diacritiques [d] (Les signes accentués DìÅçrîtïc sont les caractères accentués étendus, y compris les ß, µ, œ, etc)
        requete.sortDescriptors = [NSSortDescriptor(key: "nom", ascending: true)]
        do {
            let resultas = try context.fetch(requete)
            print(resultas)
        } catch {
            print("Erreur lecture données : \(error)")
        }
    }
    
    func saveData() -> Void {
        do {
            try context.save()
            print("Sauvegarde dans la base avec succès")
        } catch {
            print("Erreur sauvegarder CoreData : \(error)")
        }
        
    }

    @IBAction func changeFormButton(_ sender: UIButton) {
        
        let buttonPosition = sender.convert(CGPoint(), to:tableView)
        let indexInTabTaches: Int = (tableView.indexPathForRow(at:buttonPosition)?.row)!
        
        if(sender.tag == 1){
            sender.setImage(UIImage(named:"croix"), for: UIControl.State.normal)
            sender.tag = 1
            saveDateFor(tasks[indexInTabTaches])
        }else{
            sender.setImage(UIImage(named:"rond"), for: UIControl.State.normal)
            sender.tag = 0
            saveDateFor(tasks[indexInTabTaches])
        }
    }
    
    func saveDateFor(_ tache: Tache){
        print("Ok, ça marche avec : ")
        print(tache)
        //code pour sauvegarde de la dateDebut, fin et maj fin
        if(tache.dateDebut != nil){
            if(tache.dateFin != nil){
                //let calendar = NSCalendar.current
                let gregorian = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
                let r = gregorian?.components(NSCalendar.Unit.second, from: tache.dateDebut!, to: tache.dateFin!, options:.matchFirst)
                
                print(r!.second)
                
                
            }else{
                tache.dateFin = Date()
            }
        }else{
            tache.dateDebut = Date()
        }
    }
    
}


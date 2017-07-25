//
//  WeatherInfoTableViewController.swift
//  WeatherInfo
//
//  Created by Amarnath Manipatra on 25/07/17.
//  Copyright © 2017 otd. All rights reserved.
//

import UIKit
import CoreData

class WeatherInfoTableViewController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        fr.sortDescriptors = [NSSortDescriptor(key: "cityName", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: AppDelegate.stack.context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nb = fetchedResultsController!.object(at: indexPath) as! Weather
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath)
        cell.textLabel?.text = nb.cityName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if let context = fetchedResultsController?.managedObjectContext, let note = fetchedResultsController?.object(at: indexPath) as? Weather, editingStyle == .delete {
            context.delete(note)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeatherDetail" {
            
            if let indexPath = tableView.indexPathForSelectedRow, let weatherDetail = fetchedResultsController?.object(at: indexPath) as? Weather, let vc = segue.destination as? WeatherDetailViewController {
                
                vc.weatherData = weatherDetail
            }
            
        }
        
    }
    

   

}

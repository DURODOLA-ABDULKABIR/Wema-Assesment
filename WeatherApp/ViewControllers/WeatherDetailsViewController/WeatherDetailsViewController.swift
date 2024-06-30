//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by durodola on 29/06/2024.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maximumTempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    let currentDate = Date()
    let dateFormatter = DateFormatter()
   
    var weather: [Weather]?
    var main: Main?
    var cityName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        dateFormatter.dateFormat = "dd MMM yyyy"
        let formattedDate = dateFormatter.string(from: currentDate)
        
        temperatureLabel.text = "\(main?.temp ?? 0.00)°"
        maximumTempLabel.text = "\(main?.tempMax ?? 0.00)°"
        minTempLabel.text = "\(main?.tempMin ?? 0.00)°"

        if weather?.count != 0 {
            let WeatherDetails = weather?[0]
            let weatherDescription = WeatherDetails?.description ?? ""
            weatherDescriptionLabel.text = weatherDescription.prefix(1).uppercased() + weatherDescription.dropFirst()
            switch WeatherDetails?.main {
            case "Clouds":
                weatherImage.image = UIImage(systemName: "cloud.fill")
            case "Rain":
                weatherImage.image = UIImage(systemName: "cloud.rain.fill")
            default:
                weatherImage.image = UIImage(systemName: "cloud.sun.fill")
            }
        }
        dateLabel.text = "Today, \(formattedDate)"
        cityNameLabel.text = cityName
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

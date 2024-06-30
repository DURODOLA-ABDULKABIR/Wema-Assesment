//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by durodola on 29/06/2024.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityNameTextfield: ThemeTextField!

    let networkManager: WeatherDetailsNetwork
    let units: String
    var cityName: String

    init(networkManager: WeatherDetailsNetwork, units: String = "metric", cityName: String = "") {
        self.networkManager = networkManager
        self.units = units
        self.cityName = cityName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.networkManager = WeatherDetailsNetwork()
        self.units = "metric"
        self.cityName = ""
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        loaderIndicator.hidesWhenStopped = true
        switchButton.addTarget(self, action: #selector(onSwitchValueChanged), for: .valueChanged)
        setUpView()
    }

    func setUpView() {
        cityNameTextfield.text = UserDefault.getSavedCity()
    }

    @objc func onSwitchValueChanged(sender: UISwitch!) {
        cityName = cityNameTextfield.text ?? ""
        if cityName.isEmpty {
            showAlert(title: "Notice", message: AppError.cityNameError)
            sender.isOn = false
        } else {
            switch sender.isOn {
            case true:
                UserDefault.saveCity(cityName: cityName)
            case false:
                UserDefault.removeSavedCity()
            }
        }
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func getWeatherDetails() {
        loaderIndicator.startAnimating()
        networkManager.getWeatherDetails(CityName: cityNameTextfield.text ?? "", units: units, appID: AppID.appID)
    }

    func gotoWeatherDetails(weather: [Weather], main: Main, cityName: String) {
        if let weatherDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherDetailsVC") as? WeatherDetailsViewController {
            weatherDetailVC.weather = weather
            weatherDetailVC.main = main
            weatherDetailVC.cityName = cityName
            self.present(weatherDetailVC, animated: false, completion: nil)
        }
    }

    @IBAction func getDetailsTapped(_ sender: Any) {
        if cityNameTextfield.text?.isEmpty == true {
            showAlert(title: "Notice", message: AppError.cityNameError)
        } else {
            getWeatherDetails()
        }
    }
}

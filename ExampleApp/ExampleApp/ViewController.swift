//
//  ViewController.swift
//  ExampleApp
//
//  Created by 박준하 on 3/28/24.
//

import UIKit
import Then
import SnapKit
import AVSlider

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let slider = AVSlider().then {
            $0.backgroundColor = .lightGray
            $0.tintColor = .red
            $0.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        }
        
        view.addSubview(slider)
        
        slider.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc func sliderValueChanged(_ slider: AVSlider) {
        print("Slider value changed: \(slider.progress)")
    }
}

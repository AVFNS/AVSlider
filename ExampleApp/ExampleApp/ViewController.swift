import UIKit
import SnapKit
import AVSlider
import Then

class ViewController: UIViewController {
    
    let slider1 = AVSlider(frame: .zero, showValueLabel: true).then {
        $0.backgroundColor = .white
        $0.tintColor = .blue
        $0.progress = 0.3
        $0.setValueLabelPosition(.top)
        $0.valueLabel?.textColor = .red
    }
    
    let slider2 = AVSlider(frame: .zero, showValueLabel: true).then {
        $0.backgroundColor = .white
        $0.tintColor = .green
        $0.trackingMode = .absolute
        $0.progress = 0.7
        $0.setValueLabelPosition(.bottom)
        $0.valueLabel?.textColor = .blue
    }
    
    let slider3 = AVSlider(frame: .zero, showValueLabel: false).then {
        $0.backgroundColor = .white
        $0.tintColor = .red
        $0.trackingMode = .absolute
        $0.progress = 0.7
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        slider1.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        slider2.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        slider3.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        view.addSubview(slider1)
        
        view.addSubview(slider2)
        

        view.addSubview(slider3)
        
        slider1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
        
        slider2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        slider3.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-100)
        }
    }
    
    @objc func sliderValueChanged(_ slider: AVSlider) {
        slider1.valueLabel?.text = "\(slider1.progress)"
        slider2.valueLabel?.text = "\(slider2.progress)"
    }
}

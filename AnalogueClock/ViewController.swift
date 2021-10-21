//
//  ViewController.swift
//  AnalogueClock
//
//  Created by Doyoung on 2021/10/20.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var clockFace: ClockFace = {
        let clockFace = ClockFace(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
        return clockFace
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(setTime), for: .touchUpInside)
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .systemYellow
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(clockFace)
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(self.clockFace.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func setTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 1) {
                self.clockFace.value = 30
            }
        }
    }

}

class ClockFace: UIView {
  
    let needle = UIView()
    var totalAngle: CGFloat = 360
    var rotation: CGFloat = 360
    var value: Int = 0 {
        didSet {
            let needlePosition = CGFloat(value) / 100
            
            let lerpFrom = rotation
            let lerpTo = rotation + totalAngle
            
            let needleRotation = lerpFrom + (lerpTo - lerpFrom) * needlePosition
            needle.transform = CGAffineTransform(rotationAngle: deg2rad(needleRotation))
        }
    }
    
    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
    
    func setUp() {
        needle.backgroundColor = .systemYellow
        needle.translatesAutoresizingMaskIntoConstraints = false
        needle.bounds = CGRect(x: 0, y: 0, width: 4, height: bounds.height / 3)
        needle.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        needle.center = CGPoint(x: bounds.midX, y: bounds.midY)
        addSubview(needle)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
}

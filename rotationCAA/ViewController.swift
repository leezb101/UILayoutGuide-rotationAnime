//
//  ViewController.swift
//  rotationCAA
//
//  Created by leezb101 on 2018/8/4.
//  Copyright © 2018年 GDCY. All rights reserved.
//

import UIKit
let screenW = UIScreen.main.bounds.width
let screenH = UIScreen.main.bounds.height
class ViewController: UIViewController {
    
    lazy var img: UIImageView = {
        let result = UIImageView(image: #imageLiteral(resourceName: "testIcon"))
        result.frame = CGRect(x: screenW / 2 - 100, y: screenH / 2 - 100, width: 200, height: 200)
        result.layer.backgroundColor = UIColor.red.cgColor
        return result
    }()
    
    let titlesArray = ["左上角", "右上角", "左下角", "右下角", "中心"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(img)
        createButtons()

//        setAnchorPoint(point: CGPoint(x: 0.5, y: 0.5), for: img)

        // Do any additional setup after loading the view, typically from a nib.
    }

    func createButtons() {
        var lastBtn: UIButton?
        var lastSpace: UILayoutGuide?
        for (index, value) in titlesArray.enumerated() {
            let btn = UIButton(type: .system)
            btn.setTitle(value, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.tag = index + 14159
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.invalidateIntrinsicContentSize()
            view.addSubview(btn)
            btn.addTarget(self, action: #selector(addAnimation(sender:)), for: .touchUpInside)
            
            // 布局
            btn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
            btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            var space = UILayoutGuide()
            view.addLayoutGuide(space)
            
            if (lastBtn == nil) {
                space.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
                space.rightAnchor.constraint(equalTo: btn.leftAnchor).isActive = true
            } else if ( lastBtn != nil) {
                space.leftAnchor.constraint(equalTo: lastBtn!.rightAnchor).isActive = true
                space.rightAnchor.constraint(equalTo: btn.leftAnchor).isActive = true
                space.widthAnchor.constraint(equalTo: lastSpace!.widthAnchor).isActive = true
            }
            if index == titlesArray.count - 1 {
                let tailing = UILayoutGuide()
                view.addLayoutGuide(tailing)
                tailing.leftAnchor.constraint(equalTo: btn.rightAnchor).isActive = true
                tailing.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
                tailing.widthAnchor.constraint(equalTo: lastSpace!.widthAnchor).isActive = true
            }
            lastBtn = btn
            lastSpace = space
        }
    }
    
    @objc func addAnimation(sender: UIButton) {
        img.layer.removeAllAnimations()
        var archor: CGPoint
        switch sender.tag - 14159 {
        case 0:
            archor = CGPoint(x: 0, y: 0)
        case 1:
            archor = CGPoint(x: 1, y: 0)
        case 2:
            archor = CGPoint(x: 0, y: 1)
        case 3:
            archor = CGPoint(x: 1, y: 1)
        case 4:
            archor = CGPoint(x: 0.5, y: 0.5)
        default:
            return
        }
        setAnchorPoint(point: archor, for: img)
        let ani = CABasicAnimation(keyPath: "transform.rotation.z")
        ani.toValue = -Double.pi / 2
        ani.duration = 0.6
        ani.fromValue = 0
        ani.repeatCount = Float(Int.max)
        ani.autoreverses = true
        img.layer.add(ani, forKey: "someRotation")
    }
    
    func setAnchorPoint(point: CGPoint, for view: UIView) {
        let oldFrame = view.frame
        view.layer.anchorPoint = point
        view.frame = oldFrame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  ShapeTouch
//
//  Created by Don Mag on 7/14/17.
//  Copyright © 2017 DonMag. All rights reserved.
//

import UIKit


class ShapeView: UIView {
	
	var color: UIColor? {
		didSet {
			self.setNeedsDisplay()
		}
	}
	
	init(frame: CGRect, color: UIColor) {
		super.init(frame: frame)
		self.color = color
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		drawShape(rect: rect, color: self.color!)
	}
	
	func drawShape(rect: CGRect,color: UIColor) {
		guard let ctx = UIGraphicsGetCurrentContext() else { return }
		ctx.setFillColor(UIColor.clear.cgColor)
		
		ctx.beginPath()
		ctx.move(to: CGPoint(x: rect.width / 2, y: 0))
		ctx.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
		ctx.addLine(to: CGPoint(x: rect.width / 2 , y: rect.height))
		ctx.addLine(to: CGPoint(x: 0, y: rect.height / 2))
		
		
		ctx.closePath()
		ctx.setFillColor(color.cgColor)
		ctx.fillPath()
		ctx.strokePath()
	}
	
	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		let path = UIBezierPath(ovalIn: self.frame)
		return path.contains(point)
	}
}


class ViewController: UIViewController {
	
	var shape1: ShapeView?
	var frame: CGRect?
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		let x = view.frame.midX
		let y = view.frame.midY
		
		self.frame = CGRect(x: x, y: y, width: 100, height: 100)
		
		self.shape1 = ShapeView(frame: frame!, color: .red)
		shape1?.backgroundColor = .clear
		view.addSubview(shape1!)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let location = touches.first!.location(in: self.view)
		if (shape1?.point(inside: location, with: event))! {
			print("inside shape1")
			shape1?.color = UIColor.black
		} else {
			print("outside shape1")
			shape1?.color = UIColor.red
		}
	}
	
}

//
//  StaggeredGridViewController.swift
//  StaggeredGridViewController
//
//  Created by Ian Castillo on 10/2/24.
//

import UIKit

class StaggeredGridViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Vertical StackView (Main container)
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainStackView)
        
        // ScrollView Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Add Rows (Horizontal StackViews) with items
        for _ in 0..<10 {
            let horizontalStackView = createRow()
            mainStackView.addArrangedSubview(horizontalStackView)
        }
    }
    
    // Create a horizontal row of items
    func createRow() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally  // Allow items to take up different widths
        stackView.spacing = 10
        
        // Randomize the number of items in the row for more irregularity
        let itemCount = Int(arc4random_uniform(3)) + 2
        
        // Add items to this row with varying widths and heights
        for _ in 0..<itemCount {
            let view = createStaggeredView(widthMultiplier: CGFloat(arc4random_uniform(2) + 1), heightMultiplier: CGFloat(arc4random_uniform(2) + 1))
            stackView.addArrangedSubview(view)
        }
        
        return stackView
    }
    
    // Create each grid item with a different width, height, and an icon
    func createStaggeredView(widthMultiplier: CGFloat, heightMultiplier: CGFloat) -> UIView {
        let view = UIView()
        view.backgroundColor = randomColor()
        
        view.widthAnchor.constraint(equalToConstant: 80 * widthMultiplier).isActive = true
        view.heightAnchor.constraint(equalToConstant: 100 * heightMultiplier).isActive = true
        
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        
        if let icon = randomIcon() {
            iconImageView.image = icon
        } else {
            iconImageView.image = UIImage(systemName: "questionmark.circle") // Fallback icon if no random icon
        }
        
        view.addSubview(iconImageView)
        
        // Center the icon inside the view
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return view
    }
    
    // Utility function to generate random colors
    func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255
        let green = CGFloat(arc4random_uniform(256)) / 255
        let blue = CGFloat(arc4random_uniform(256)) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    // Utility function to get random SF Symbols icons
    func randomIcon() -> UIImage? {
        let icons = [
            "message.fill",
            "phone.fill",
            "envelope.fill",
            "gearshape.fill",
            "wifi",
            "bluetooth",
            "airplane",
            "bell.fill"      
        ]
        
        let randomIndex = Int(arc4random_uniform(UInt32(icons.count)))
        return UIImage(systemName: icons[randomIndex])
    }
}

import UIKit

class StaggeredGridViewController: UIViewController {
    
    // Reusable pool for views to optimize memory usage
    private var viewPool: [UIView] = []
    private var iconCache: [String: UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ScrollView to hold the entire layout
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Main horizontal stack view to hold the columns
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fillEqually  // Evenly distribute columns
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
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)  // Match the scrollView width
        ])
        
        // Determine the number of columns based on the device size
        let columnCount = calculateColumnCount()
        
        // Add vertical stack views for columns
        for _ in 0..<columnCount {
            let columnStackView = createColumn()
            mainStackView.addArrangedSubview(columnStackView)
        }
    }
    
    // Function to calculate the number of columns based on device width
    func calculateColumnCount() -> Int {
        let screenWidth = UIScreen.main.bounds.width
        
        // iPad Pro 13-inch: Wider screen, more columns
        if screenWidth >= 1024 {
            return 6  // More columns for iPad Pro
        }
        
        // iPhone SE: Narrower screen, fewer columns
        return 3  // Fewer columns for iPhone SE
    }
    
    // Create a vertical column stack of items
    func createColumn() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        // Generate more items for larger devices (more content to scroll)
        let itemCount = calculateItemCount()
        
        for _ in 0..<itemCount {
            let view = createStaggeredView(widthMultiplier: 1, heightMultiplier: CGFloat(arc4random_uniform(3) + 1))  // Different height for each item
            stackView.addArrangedSubview(view)
        }
        
        return stackView
    }
    
    // Function to calculate the number of items per column based on device size
    func calculateItemCount() -> Int {
        let screenHeight = UIScreen.main.bounds.height
        
        // For iPad Pro (more items to scroll)
        if screenHeight >= 1366 {
            return 20  // More items for iPad Pro 13-inch
        }
        
        // For iPhone SE (fewer items to scroll)
        return 10  // Fewer items for iPhone SE
    }
    
    // Create each grid item with a different height and icon
    func createStaggeredView(widthMultiplier: CGFloat, heightMultiplier: CGFloat) -> UIView {
        // Reuse views from the pool to optimize memory
        let view: UIView
        if let reusableView = viewPool.popLast() {
            view = reusableView
            view.subviews.forEach { $0.removeFromSuperview() }  // Clean up previous icon
        } else {
            view = UIView()
        }
        
        view.backgroundColor = randomColor()
        
        // Set width and height constraints
        view.widthAnchor.constraint(equalToConstant: 80 * widthMultiplier).isActive = true
        view.heightAnchor.constraint(equalToConstant: 100 * heightMultiplier).isActive = true
        
        // Add an icon (UIImageView) inside the view
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        
        let iconName = randomIconName()
        if let cachedIcon = iconCache[iconName] {
            iconImageView.image = cachedIcon
        } else {
            let newIcon = UIImage(systemName: iconName)
            iconImageView.image = newIcon
            iconCache[iconName] = newIcon  // Save it in the cache
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
    
    // Utility function to get random SF Symbols icon names
    func randomIconName() -> String {
        let icons = [
            "message.fill",  // Message icon
            "phone.fill",    // Phone icon
            "envelope.fill", // Mail icon
            "gearshape.fill",// Settings icon
            "wifi",          // Wi-Fi icon
            "bluetooth",     // Bluetooth icon
            "airplane",      // Airplane icon
            "bell.fill"      // Notification/Bell icon
        ]
        
        let randomIndex = Int(arc4random_uniform(UInt32(icons.count)))
        return icons[randomIndex]
    }
}

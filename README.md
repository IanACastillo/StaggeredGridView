# Staggered Grid Layout with Dynamic Icons

This project demonstrates the implementation of a **staggered grid layout** using **UIKit** with a focus on dynamic grid item sizing and memory-efficient rendering. Each grid item contains a unique, randomly chosen icon, and the grid layout is designed to be irregular, visually appealing, and scrollable. The project also includes memory optimizations by reusing views and caching icons.

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Memory Optimization](#memory-optimization)

## Features

- **Staggered Grid Layout**: Irregular grid layout where each grid item has a different size (both in width and height) to create a dynamic, staggered look.
- **Dynamic Icons**: Each grid item displays a random **SF Symbol** icon (e.g., Bluetooth, Messaging, Wi-Fi).
- **Scroll Support**: The entire grid is enclosed within a `UIScrollView` for smooth vertical scrolling.
- **Memory Efficiency**: 
  - **View Reuse**: Views are reused to reduce memory overhead.
  - **Icon Caching**: Icons are cached to avoid redundant `UIImage` creation.

## Technologies Used

- **UIKit**: For creating the user interface, including `UIScrollView` and `UIStackView`.
- **SF Symbols**: Built-in system icons for grid item representation.
- **Swift**: The programming language used for the entire project.

## Installation

To run the project locally, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/staggered-grid-layout.git
### Open the Project in Xcode:
- Navigate to the cloned directory and open the `.xcodeproj` or `.xcworkspace` file.

### Build and Run:
1. Select your target device or simulator.
2. Click **Run** (⌘R) to build and run the project.

### Usage

Once the project is running, you’ll see a scrollable staggered grid layout with multiple rows. Each row contains a random number of grid items (between 2 to 4), and each grid item has a different width and height for a visually dynamic appearance. Each item contains an icon randomly selected from the following list:

- Messaging
- Phone
- Email
- Settings
- Wi-Fi
- Bluetooth
- Airplane mode
- Notifications

### Memory Optimization

The project is designed with performance and memory optimization in mind, focusing on the following aspects:

- **View Reuse**:
  - Instead of creating new views for each grid item, views are reused from a pool to avoid unnecessary memory allocation.
  - This is especially helpful when there are a large number of grid items.

- **Icon Caching**:
  - Icons are cached in a dictionary so that the same icon is not recreated multiple times. This improves memory efficiency and ensures smoother scrolling performance.

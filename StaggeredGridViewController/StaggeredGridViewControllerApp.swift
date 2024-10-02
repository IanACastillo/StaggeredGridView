//
//  StaggeredGridViewControllerApp.swift
//  StaggeredGridViewController
//
//  Created by Ian Castillo on 10/2/24.
//
import SwiftUI
import UIKit

// Wrapper for StaggeredGridViewController
struct StaggeredGridViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> StaggeredGridViewController {
        // Create and return the instance of StaggeredGridViewController
        return StaggeredGridViewController()
    }
    
    func updateUIViewController(_ uiViewController: StaggeredGridViewController, context: Context) {
        // Leave this empty for now, since no update logic is needed
    }
}

@main
struct StaggeredGridViewControllerApp: App {
    var body: some Scene {
        WindowGroup {
            // Use the wrapper here to display your UIKit view controller
            StaggeredGridViewControllerWrapper()
        }
    }
}

//
//  Constants.swift
//  GitIt
//
//  Created by Loay Ashraf on 27/12/2021.
//

import Foundation
import UIKit
import Network

// MARK: - Constants Shortcuts

// Model Shortcuts
typealias ModelConstants = Constants.Model
typealias NetworkingConstants = ModelConstants.Networking
typealias AuthenticationConstants = NetworkingConstants.Authentication
// View Shortcuts
typealias ViewConstants = Constants.View
typealias StoryboardConstants = ViewConstants.Storyboard
typealias NavigationBarConstants = ViewConstants.NavigationBar
typealias ErrorConstants = ViewConstants.Error
typealias EmptyConstants = ViewConstants.Empty

struct Constants {
    
    // MARK: - Model Constants
    
    struct Model {
        
        struct Networking {
            
            struct Authentication {
                
                static let apiKey = "0d4d5ed1-2802-4f37-8a92-832b275554da"
                
            }
            
            static let apiBaseUrl = "https://api.thecatapi.com/v1"
            
            static let publicImages = "images/search"
            
            static let query = "q"
            static let sort = "sort"
            static let order = "order"
            static let page = "page"
            static let perPage = "limit"
            
            static let contentType = "Content-Type"
            static let contentLength = "Content-Length"
    
            static let maxPageCount = 1000
            static let minimumPageCapacity = 10
            
        }
        
    }
    
    // MARK: - Services Constants
    
    struct Services {
        
        
    }
    
    // MARK: - View Constants
    
    struct View {
        
        struct Storyboard {
            
            static let main = UIStoryboard(name: "Main", bundle: nil)
            
        }
        
        // MARK: - Navigation Bar Constants
        
        struct NavigationBar {
            
            static func configureAppearance(for navigationBar: UINavigationBar?) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.titleTextAttributes[.foregroundColor] = UIColor.white
                appearance.largeTitleTextAttributes[.foregroundColor] = UIColor.white
                appearance.backgroundColor = UIColor(named: "AccentColor")
                navigationBar?.standardAppearance = appearance
                navigationBar?.scrollEdgeAppearance = appearance
                navigationBar?.tintColor = .white
            }
            
        }
        
        // MARK: - Error Constants
        
        struct Error {
            
            // Internet error image, title and message
            struct Internet {
                
                static private let image = UIImage(systemName: "wifi.exclamationmark")
                static private let title = "No Internet".localized()
                static private let message = "You're not connected to Internet,\nplease try again later.".localized()
                static let viewModel = ErrorViewModel(image: image, title: title, message: message)

            }
            
            // Network error image, title and message
            struct Network {
                
                static private let image = UIImage(systemName: "exclamationmark.icloud")
                static private let title = "Network Error".localized()
                static private let message = "We're working on it,\nWe will be back soon.".localized()
                static let viewModel = ErrorViewModel(image: image, title: title, message: message)
                
            }
            
        }
        
        // MARK: - Empty Constants
        
        struct Empty {
            
            // General empty image and title
            struct General {
                
                static private let image = UIImage(systemName: "exclamationmark")
                static private let title = "WoW, such empty".localized()
                static let viewModel = EmptyViewModel(image: image, title: title)
                
            }
            
        }
        
    }
    
}

# MVVM Testing Example

<p float="left">
<a href="https://github.com/loay-ashraf/MVVM-Testing-Example/actions/workflows/iOSBuildCI.yml">
<img src="https://img.shields.io/github/workflow/status/loay-ashraf/MVVM-Testing-Example/iOS%20Build%20CI">
</a>
<a href="https://github.com/loay-ashraf/MVVM-Testing-Example/actions/workflows/iOSTestCI.yml">
<img src="https://img.shields.io/github/workflow/status/loay-ashraf/MVVM-Testing-Example/iOS%20Test%20CI?label=test">
</a>
<a href="https://en.wikipedia.org/wiki/Model–view–viewmodel">
<img src="https://img.shields.io/badge/architecture-MVVM-brightgreen">
</a>
<img src="https://img.shields.io/badge/swift-5.5-orange">
<img src="https://img.shields.io/badge/iOS-13.0%2B-black">
</p>

This is an example of using XCTest framework to test a simple application built around MVVM architecture.

## Features

- Application of FIRST principles 
- Unit testing Model and View Model as separate units with Mocks and Stubs
- Unit testing whole module (Model with View Model) with stubbed response to ensure correct data flow
- Unit testing whole module (Model with View Model) with real response to ensure backend service is working
- UI testing View to verify user interactions
- UI testing application startup performance

## References

### Third Party Libraries
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs)

### Tools
* Xcode 13.2
* iPhone 12 Simulator (iOS 14.5)

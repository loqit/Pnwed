# Pnwed
API: [API Doc](https://haveibeenpwned.com/API/v3)

## How to Run the Project
Follow these steps to set up and run the project on your local machine:

## Step 1: Install Pods
Navigate to the project directory in your terminal.

Install Cocoapods dependecies:<br>
```bash
$ pod install
```

## Step 2: Add ProjectConstants.swift
In the project directory, create a new Swift file named ProjectConstants.swift.

Open ProjectConstants.swift and define the necessary API keys and endpoints. For example:
```swift
import Foundation

struct ProjectConstants {
    static let apiKey = "YOUR_API_KEY"
    static let baseURL = "https://api.yourservice.com/"
}
```

## Step 3: Open the Project in Xcode
Open the .xcworkspace file in Xcode

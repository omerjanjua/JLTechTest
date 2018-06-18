# JLTechTest
The task was to write an iPad app, in Swift, to allow customers to see the range of dishwashers John Lewis sells.

When the app is launched, the customer should be presented with a grid of dishwashers that are currently available for customers to buy, with only the first 20 results returned by the API to be displayed.

When a dishwasher is tapped, a new screen should be displayed showing the dishwasher’s details.

# Requirements
- Xcode Version 9.4.1

# Building
- Run carthage update in the root directory

# Assumptions
- No data persistence required. However if I was to implement something for offline functionality. I would use REALM 

# Architecture
- Depending on the complexity of the app you can chose MVC/MVVM. However since this is a test for John Lewis which is a high scale application. I decided to use VIPER which seemed best suited for this test.

# Testing
- I tested the presenters. If I was going to spend more time on this I would come back and implement some mocks for the UIAlertControllers and test those.

# Notes
- I used SwiftyJSON for the JSON parsing however if I was going to come back and refactor this I would make use of Codable which was introduced in Swift 4
- The product detail screen is not finished up to the most pretty UI standards. If I was to come back and refactor this I would use all the images given in the API response for product details instead of just picking one from the array as done currently. 

# Points for Improvement
- Product Detail Screen landscape UI
Summary
 Shopping Collection is a mobile e-commerce app that allows users to browse and purchase products 
across various categories. The app provides a seamless shopping experience with features like product 
details, a shopping cart, order history, and user authentication.
 Project Goals
 The main goals of the Shopping Collection app are:
 • To provide an easy-to-use platform for users to shop for products on their mobile devices 
• To offer a wide selection of products across categories like laptops, phones, shoes, and watches 
• To allow users to view product details, select options, add items to cart, and complete purchases 
• To provide order history and profile management for registered users 
Features of the App
 The Shopping Collection app includes the following main features:
 • User Authentication: 
• Login functionality with email and password 
• Sign up functionality with full name, email, and password 
• Password reset functionality 
• User logout 
2. Homepage: 
• Displays a grid of products with images, names, and prices 
• Search functionality to filter products by name 
• Category chips to filter products by category 
• Navigates to the product details page when a product is tapped 
3. Product Details: 
• Displays the selected product's image, name, price, and options 
• Allows selecting an option for the product 
• Add to Cart button to add the selected product to the shopping cart 
4. Shopping Cart: 
• Displays a list of added cart items with product image, name, option, and price 
• Allows removing individual items from the cart 
• Provides a Clear Cart button to remove all items at once 
• Displays the total amount of the items in the cart 
• Provides a Purchase Now button to confirm the order 
5. Order Placement: 
• Creates a new order in Firestore when the Purchase Now button is tapped 
• Associates the order with the logged-in user 
• Clears the cart after a successful order placement 
6. User Profile: 
• Displays the logged-in user's name, email, and avatar 
• Shows the order history of the user 
• Allows logging out of the app 
7. Order History: 
• Fetches and displays the user's order history from Firestore 
• Shows order details including order ID, date, total amount, and items 
• Displays an empty state message if no orders are found 
8. Bottom Navigation: 
• Provides navigation between the Home, Cart, and Profile pages 
9. Theming and Styling: 
• Uses a custom light theme with primary and secondary colors 
• Applies custom text styles and font sizes 
• Utilizes Material Design components and styles 
10.Firebase Integration: 
• Uses Firebase Authentication for user authentication 
• Stores user information in Firestore 
• Stores order details in Firestore 
• Retrieves user orders from Firestore 
11.State Management: 
• Uses Provider package for managing the shopping cart state 
• Updates the UI when cart items are added or removed 
12.Product Catalog: 
• Maintains a list of products with details like ID, name, price, image URL, options, and 
category 
• Allows filtering products by category and search query 
13.Error Handling: 
• Displays error messages using SnackBars for authentication errors, network errors, etc. 
• Shows loading indicators during asynchronous operations 
14.Responsive Layout: 
• Adjusts the number of columns in the product grid based on screen width 
• Uses Flexible and Expanded widgets to create responsive layouts 
15.Image Handling: 
• Displays product images using Image.asset 
• Provides a placeholder image for products without a valid image URL 
16.Dialogs and Alerts: 
• Shows confirmation dialogs for actions like clearing the cart or deleting an item 
• Displays success and error messages using SnackBars 
17.Form Validation: 
• Validates user input in login and sign-up forms 
• Checks for required fields, email format, and password length 
• Displays validation error messages
 Steps to Create the App
 1. Planning: Decided on building an e-commerce app with browsing, cart, and profile features. 
Sketched out required screens and user flow. 
2. Designing: Created layouts for the home screen, product details, cart, login, sign up and profile 
screens. Defined the app theme and styles. 
3. Coding: Implemented the screens and features using Flutter and Dart. Integrated with Firebase 
for authentication, Firestore for orders, and Cloud Storage for images. Created models and 
services to handle products, cart items, and orders. 
4. Testing: Ran the app on an emulator and physical device to test the flow and features. Also 
tested on chrome to ensure its working on different screen sizes and responsive, Debugged and 
fixed issues encountered. 
Tools and Technology
 The main tools and technologies used to build the Shopping Collection app are:
 • Framework: Flutter 
• Programming Language: Dart 
• IDE: Android Studio & Vs Code
 • Backend: Firebase (Authentication, Firestore, Cloud Storage) 
• State Management: Provider package 
Challenges Faced
 Some of the key challenges encountered during the development of the app were:
 • Implementing the option selection and add to cart flow on the product details screen 
• Architecting the models and services to handle products, cart items, and orders 
• Integrating Firebase services for authentication, database, and storage 
• Passing data between screens and keeping the cart and order history in sync 
These challenges were overcome by carefully designing the models, breaking down the features into 
smaller tasks, referring to Flutter and Firebase documentation, and persistent debugging.
 Conclusion
 Building the Shopping Collection app provided great experience in full-stack mobile app development 
using Flutter and Firebase. Key learnings include architecting and integrating multiple features, 
working with different Firebase services, and managing app state.
 Given more time, additional features that could be added are:
 • User reviews and ratings for products 
• Favorites or wishlist for users to save products 
• Product recommendations based on user's purchase and browsing history 
• More payment options and order trackin

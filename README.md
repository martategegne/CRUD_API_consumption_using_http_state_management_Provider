# Photo Manager App (Flutter CRUD)

## Student Information

| Name           | ID           | Section   |
|----------------|-------------|-----------|
| Marta Tegegne  | UGR/4457/16 | Section-1 |

## Description

This is a Flutter application that performs **CRUD (Create, Read, Update, Delete)** operations using a public REST API.  
The app uses **Provider** for state management and the **http** package for network requests.

It allows users to view, add, update, and delete photos while handling loading and error states efficiently.


##  Features

- 📥 Fetch photos from API  
- ➕ Add new photo  
- ✏️ Update existing photo  
- 🗑️ Delete photo  
- ⏳ Loading indicator  
- ⚠️ Error handling  

## 📸 Screenshots


## Tech Stack

- **Flutter**

- **Provider (State Management)**

- **HTTP Package (API Calls)**

##  API Used

- https://jsonplaceholder.typicode.com/photos


## 📂 Project Structure

lib/

│

├── models/

├── services/

├── providers/

├── screens/

└── main.dart

##  How to Run

1. Clone the repository:

git clone https://github.com/your-username/your-repo-name.git


2. Navigate to the project:

cd your-repo-name


3. Install dependencies:

flutter pub get


4. Run the app:

flutter run


## Notes

- This project demonstrates proper separation of concerns:

  - Model

  - Service (API)

  - Provider (State Management)

  - UI
    
- Follows clean and maintainable Flutter architecture.

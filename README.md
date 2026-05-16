# User Manager App (Flutter CRUD)

## Student Information

| Name | ID | Section |
|------|----|---------|
| Marta Tegegne | UGR/4457/16| Section-1 |


## Description

This is a Flutter application that performs **CRUD (Create, Read, Update, Delete)** operations using a public REST API (**DummyJSON API**).

The app is built using:

- **Provider** for state management

- **http package** for network requests

- Clean architecture with separation of concerns (Model, Service, Provider, UI)

It allows users to:

- View a list of users from an API

- Add new users (locally + API request)

- Edit existing users

- Delete users

- Handle loading and error states properly


## Features

- 📥 Fetch users from public API (DummyJSON)

- ➕ Add new user
 
- ✏️ Edit user details (first name, last name, email)

- 🗑️ Delete user

- ⏳ Loading indicator while fetching data

- ⚠️ Error handling for network failures

- 🧠 State management using Provider


##  Screenshots

> Add screenshots of your app here

- Home Screen (User List)
  <img width="984" height="705" alt="image" src="https://github.com/user-attachments/assets/cc5543e0-f525-4003-a9cd-60112f840568" />

- Add User Dialog
  <img width="993" height="707" alt="image" src="https://github.com/user-attachments/assets/770dd4c1-fa8e-411e-b058-7db2c9bcb79e" />

- Edit User Dialog
  <img width="981" height="708" alt="image" src="https://github.com/user-attachments/assets/b7aa4601-d2a8-4e51-aa4f-d6458db174d2" />

- Loading State

-Add new user
<img width="998" height="711" alt="image" src="https://github.com/user-attachments/assets/629286d7-95d8-4ca0-9d23-3ab192f2d8b0" />

-Delete user
<img width="996" height="709" alt="image" src="https://github.com/user-attachments/assets/f8a6496c-7401-4a3d-bb9a-d2ec8b081398" />


## Tech Stack

- Flutter

- Provider (State Management)

- HTTP Package (API Calls)

- Material Design UI


## API Used

- DummyJSON Users API
 
 - https://dummyjson.com/users



##  Project Structure

lib/

│
├── models/

│ └── user.dart

│
├── services/

│ └── api_service.dart

│
├── providers/

│ └── user_provider.dart

│
├── screens/

│ └── home_screen.dart

│
└── main.dart


## How It Works

### 1. Data Flow
- ApiService` handles HTTP requests

- UserProvider` manages app state

- UI listens using `Consumer<UserProvider>`

### 2. CRUD Operations

- **Create** → Adds user locally and sends POST request

- **Read** → Fetches users from API

- **Update** → Updates user in list + sends PUT request

- **Delete** → Removes user from list + sends DELETE request


## How to Run

1. Clone the repository:
bash
git clone https://github.com/martategegne/CRUD_API_consumption_using_http_state_management_Provider.git

2. Navigate into the project:
cd user-manager-app
3.Install dependencies:

4. flutter pub get

Run the app:
flutter run
## Notes

- This project demonstrates clean Flutter architecture using Provider for state management.

- The app communicates with the DummyJSON REST API using HTTP requests for all CRUD operations.

- Since this is a demo API, POST, PUT, and DELETE requests do not permanently persist changes on the server.

- For a better user experience, the UI is updated immediately using local state after successful API calls.

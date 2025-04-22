# web_demo

# Photovoltaic System Planner – Flutter Web App ☀️

A responsive web application built with Flutter that allows users to simulate and manage photovoltaic (PV) system projects across various global locations. 
The app includes a visual planning interface, integrated maps, and a project-based structure for evaluating solar energy production.

## 🔍 Project Overview

Developed as a frontend contribution to a university project on photovoltaic system planning (Summer 2023), built using Flutter Web. 
The web app helps users assess photovoltaic system efficiency based on location and technical parameters using digital tools.

## ✨ Features

- **User Management**: Users can register, log in, update and delete their accounts (soft delete supported)
- **Project Management**: Create, edit, delete, and filter PV system projects
- **Product Management**: Add up to three PV products per project, with support for three predefined PV system configurations
- **Geolocation**: Integration with Google Maps for location selection and management
- **Parameter Input**: Users provide the required 6 parameters for simulation:
    - Power peak
    - Orientation (N/E/S/W)
    - Inclination/Tilt
    - Area (m²)
    - Latitude
    - Longitude
- **Map Interaction**: View, add, update, and delete PV products directly on the map interface
- **Read-only Projects**: Projects are locked for editing after report generation (feature in progress)
- **Data Visualization**: Placeholder for electricity output charts after report generation (upcoming)

> 🚧 *Note: Report generation and charting functionality are currently in development.*

## 🛠️ Technologies Used

- **Flutter Web** – UI framework
- **Dart** – Programming language
- **Google Maps API** – Interactive location display and editing
- **Shared Preferences / REST APIs** – Local state and data interactions with backend
- **Material Design** – Clean, modern UI


## 📄 Notes

- This repository includes only the **frontend web application**.
- Backend functionality (e.g., report generation, weather data sync, email delivery) is in development and will be hosted in a separate repository.

## 🧪 How to Run (Flutter Web)

```bash
git clone https://github.com/your-username/pv-system-planner.git
cd pv-system-planner
flutter pub get
flutter run -d chrome


# Bestdeal OR/CR Assistance Website

A full-stack website for vehicle OR/CR assistance service.

## Tech Stack
- Frontend: React (Vite)
- Backend: Firebase (Auth & Firestore)
- Styling: Plain CSS

## Setup Instructions

1. **Firebase Project Setup:**
   - Create a new project in the Firebase Console.
   - Enable **Authentication** (Email/Password).
   - Enable **Cloud Firestore** and use the rules provided in `firestore.rules`.
   - Add a web app and copy the configuration.

2. **Configuration:**
   - Update `src/firebase.js` with your Firebase config.
   - Initial settings will be created on the first load of the homepage or can be manually added to Firestore in the `settings` collection under the document `main`.

3. **Running Locally:**
   ```bash
   npm install
   npm run dev
   ```

4. **Admin Access:**
   - Create an admin user in the Firebase Console (Authentication tab).
   - Go to `/admin` to log in.
   - Access the dashboard at `/admin/dashboard`.

## Important Note
- This service is for assistance and follow-up only.
- No customer data is stored in the database.
- Inquiries are redirected to Facebook Messenger.

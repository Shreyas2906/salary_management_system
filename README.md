# 💼 Salary Management System

A full-stack Salary Management System built with **Ruby on Rails (API)** and **ReactJS**, designed to manage employees, attendance, payroll, and salary insights for an organization with 10,000 employees.

---

## Features

### Admin Features

* Manage Employees (CRUD)
* View Salary Insights:

  * Min / Max / Average salary by country
  * Salary insights by job title
* View and manage attendance
* Search & filter employees (by name & role)

### Employee Features

* View personal dashboard
* Salary breakdown:

  * Monthly salary
  * Per-day salary
  * Earned salary (based on attendance)
  * Tax & Net salary
* Attendance tracking
* Payday countdown (last day of month)
* View other employees (limited data)
* Contact employees via email

---

## Tech Stack

* **Backend:** Ruby on Rails (API)
* **Frontend:** ReactJS
* **Database:** PostgreSQL
* **Authentication:** JWT
* **Testing:** RSpec
* **Charts:** Recharts

---

## Project Structure

salary_management_system_pro/
├── backend/   # Rails API
├── frontend/  # React app

---

## Setup Instructions

### Backend Setup

```bash
cd backend
bundle install
rails db:create db:migrate db:seed
rails s
```

---

### Frontend Setup

```bash
cd frontend
npm install
npm start
```

---

## Authentication

* JWT-based authentication
* Role-based access:

  * Admin
  * Employee

---

## Payroll Logic

Salary is calculated dynamically based on:

Per Day Salary = Monthly Salary / Total Days in Month
Earned Salary = Per Day Salary × Days Present
Tax = 10% of Earned Salary
Net Salary = Earned Salary - Tax

---

## Seed Data

* 10,000 employees generated
* Random names using first & last name lists
* Users created with roles:

  * Admin
  * Employees
* Attendance records generated

---

## Testing

```bash
cd backend
bundle exec rspec
```

---

## Key Highlights

* Role-based secure APIs
* Scalable architecture
* Clean UI with dashboard
* Real-world payroll logic
* Search + filtering + pagination
* Employee self-service portal

---

---

## Submission Notes

* Built using TDD principles (RSpec)
* Designed with product thinking and scalability in mind


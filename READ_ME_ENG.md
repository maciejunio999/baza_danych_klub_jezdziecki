# 📄 Database Documentation: `wiekszabaza`

## 📌 General Overview
The `wiekszabaza` database is a relational database designed to manage **equestrian clubs**, their clients, employees, horses, and associated data such as addresses, salaries, and foreign language skills.

---

## 📌 Database Structure
The database consists of **24 tables**, grouped into several main categories:

### 📍 Location
- `adresy` – Stores address details.

### 📍 Institutions
- `kluby_jezdzieckie` – Equestrian clubs.
- `szkoly` – Schools collaborating with clubs.
- `firmy` – Companies acting as clients.

### 📍 Clients
- `klienci` – Stores client contact information.
- `osoby_prywatne` – Clients who are private individuals.
- `karty_czlonkowskie` – Membership cards assigned to clients and horses.

### 📍 Animals
- `konie` – List of horses available in clubs.
- `stajnie` – Stables where horses are kept.

### 📍 Employees
- `pracownicy` – General employee data.
- `weterynarze` – Employees qualified as veterinarians.
- `sprzedawcy` – Employees handling sales in clubs.

### 📍 Foreign Languages
- `jezyki_obce` – List of foreign languages.
- `znajomosc_jezykow_obcych` – Links languages to employees.

### 📍 Finances
- `wynagrodzenia` – Salary data for employees.

---

## 📌 Key Relationships Between Tables
- **Each equestrian club (`kluby_jezdzieckie`)** has an associated **address (`adresy`)**.
- **Each club can have multiple clients (`klienci`)**, who may be either **private individuals (`osoby_prywatne`)** or **companies (`firmy`)**.
- **Each horse (`konie`)** is assigned to a single stable (`stajnie`) and a single club (`kluby_jezdzieckie`).
- **Each employee (`pracownicy`)** works for a club (`kluby_jezdzieckie`) and may also be assigned to a specific stable (`stajnie`).
- **An employee can be a veterinarian (`weterynarze`) or a seller (`sprzedawcy`)**.
- **Sellers can have knowledge of foreign languages (`znajomosc_jezykow_obcych`)**.
- **Each client may have a membership card (`karty_czlonkowskie`) that specifies which horse they ride**.
- **Each employee may have an assigned salary (`wynagrodzenia`)**.

---

## 📌 Key Fields and Their Meaning

| **Table** | **Column

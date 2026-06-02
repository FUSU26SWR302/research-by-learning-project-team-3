# Car Rental Backend

> **Self-Drive Car Rental Platform** — Authentication & Account Management Module  
> Tech Stack: **Java Servlet (Jakarta EE 6) · JSP · MS SQL Server · BCrypt · Maven**

---

## Quick Start

### Prerequisites

| Tool | Version |
|---|---|
| JDK | 17+ |
| Apache Tomcat | **10.1+** (Jakarta EE namespace required) |
| Maven | 3.8+ |
| MS SQL Server | 2019+ (or Azure SQL) |

> ⚠️ **Tomcat 9 / Java EE users:** replace all `jakarta.*` imports with `javax.*` and adjust the POM servlet-api artifact accordingly.

---

### 1 — Set Up the Database

```sql
-- Run in SSMS or Azure Data Studio:
-- File: database/schema.sql
```

This script:
- Creates the `CarRentalDB` database
- Creates the `dbo.Users` table with role/status CHECK constraints
- Seeds a default **Admin** account: `admin@carrental.com` / `Admin@123`
- Creates performance indexes on `Email` and `Role` columns

---

### 2 — Configure JDBC

Edit [`src/main/java/com/carrental/db/DBContext.java`](src/main/java/com/carrental/db/DBContext.java):

```java
private static final String URL      = "jdbc:sqlserver://localhost:1433;databaseName=CarRentalDB;...";
private static final String USERNAME = "sa";
private static final String PASSWORD = "YourActualPassword";
```

> 💡 **Production tip:** Externalise credentials using a Tomcat JNDI `DataSource`
> defined in `conf/context.xml` — never hard-code passwords in source files.

---

### 3 — Build

```bash
mvn clean package
```

Output: `target/CarRentalBackend.war`

---

### 4 — Deploy & Run

**Option A — Deploy to Tomcat:**
```
Copy target/CarRentalBackend.war → $TOMCAT_HOME/webapps/
Start Tomcat
Open: http://localhost:8080/CarRentalBackend/
```

**Option B — Embedded Tomcat (Maven plugin):**
```bash
mvn tomcat7:run
Open: http://localhost:8080/carrental/
```

---

## Module: Authentication & Authorization

### URL Routes

| Route | Method | Role Required | Description |
|---|---|---|---|
| `/` | GET | Anyone | Landing page |
| `/register` | GET, POST | Guest | UC01 – Register |
| `/login` | GET, POST | Guest | UC02 – Login |
| `/logout` | GET, POST | Any | UC03 – Logout |
| `/admin/dashboard` | GET | ADMIN | Admin dashboard |
| `/renter/dashboard` | GET | RENTER | Renter dashboard |
| `/owner/dashboard` | GET | CAR_OWNER | Car owner dashboard |
| `/staff/dashboard` | GET | STAFF | Staff dashboard |

### Roles

| Role | Value in DB | Dashboard |
|---|---|---|
| Renter | `RENTER` | `/renter/dashboard` |
| Car Owner | `CAR_OWNER` | `/owner/dashboard` |
| Admin | `ADMIN` | `/admin/dashboard` |
| Support Staff | `STAFF` | `/staff/dashboard` |

### Security Features

- ✅ **BCrypt hashing** (work-factor 12) for passwords
- ✅ **Session fixation prevention** (invalidate + recreate on login)
- ✅ **HttpOnly session cookie** (configured in `web.xml`)
- ✅ **Role-Based Access Control** via `AuthenticationFilter`
- ✅ **Account status check** (ACTIVE / INACTIVE / BANNED)
- ✅ **PRG pattern** (Post/Redirect/Get) on registration and login
- ✅ **Server-side validation** on all form submissions
- ✅ **Intentionally vague login error** (prevents email enumeration)

---

## Package Layout

```
com.carrental
├── model
│   └── User.java               POJO with role/status constants
├── db
│   └── DBContext.java          JDBC connection factory
├── dao
│   └── UserDAO.java            registerUser · checkLogin · isEmailExist
├── filter
│   └── AuthenticationFilter.java  RBAC servlet filter
└── servlet
    ├── RegisterServlet.java    UC01
    ├── LoginServlet.java       UC02
    ├── LogoutServlet.java      UC03
    ├── admin/AdminDashboardServlet.java
    ├── renter/RenterDashboardServlet.java
    ├── owner/OwnerDashboardServlet.java
    └── staff/StaffDashboardServlet.java
```

---

## Dependencies (pom.xml)

| Artifact | Purpose |
|---|---|
| `jakarta.servlet-api:6.0.0` | Servlet / Filter / HttpSession API |
| `jakarta.servlet.jsp-api:3.1.1` | JSP API |
| `jakarta.servlet.jsp.jstl-api:3.0.0` | JSTL tag library API |
| `org.glassfish.web:jakarta.servlet.jsp.jstl:3.0.1` | JSTL runtime |
| `com.microsoft.sqlserver:mssql-jdbc:12.4.2.jre11` | MS SQL Server JDBC driver |
| `org.mindrot:jbcrypt:0.4` | BCrypt password hashing |

---

## Environment Toggle

| Context-param (`web.xml`) | Value | Effect |
|---|---|---|
| `showErrorTrace` | `true` | Shows stack traces on error pages (DEV) |
| `showErrorTrace` | `false` | Hides stack traces (PRODUCTION) |

---

## Next Sprint TODOs

- [ ] Wire real DAO data into dashboard JSPs
- [ ] Externalise DB credentials to JNDI DataSource
- [ ] Implement "Forgot Password" email flow
- [ ] Add CSRF token to all POST forms
- [ ] Enable `<secure>true</secure>` session cookie for HTTPS deployments
- [ ] Add brute-force login rate limiting
- [ ] Implement audit log table for auth events

# System Architecture
## Component Details

### 1. Data Storage Layer
- **Oracle Database 21c**
- **5 Normalized Tables** (3NF compliance)
- **Referential Integrity** via foreign keys
- **Indexes** for performance optimization

### 2. Business Logic Layer
- **PL/SQL Procedures:** Business operations
- **PL/SQL Functions:** Calculations and validations
- **PL/SQL Triggers:** Business rule enforcement
- **PL/SQL Package:** Code organization

### 3. Presentation Layer
- **SQL Developer:** Administration and development
- **SQL*Plus:** Command-line interface
- **Future:** Web dashboard interface

## Data Flow
1. **Input:** Patient submits feedback via digital interface
2. **Processing:** PL/SQL validates and processes data
3. **Storage:** Data saved in Oracle tables
4. **Audit:** All operations logged in AUDIT_LOG
5. **Output:** Reports generated for management

## Security Architecture
- **Role based Access Control**
- **Audit Trail** for all operations
- **Business Rule Enforcement**
- **Data Encryption** (future enhancement)

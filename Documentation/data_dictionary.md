# Data Dictionary

## PATIENTS Table
| Column | Type | Constraints | Purpose |
|--------|------|-------------|---------|
| PATIENT_ID | NUMBER(10) | PK, NOT NULL | Unique patient identifier |
| PATIENT_NAME | VARCHAR2(100) | NOT NULL | Patient's full name |
| EMAIL | VARCHAR2(100) | UNIQUE | Contact email address |
| PHONE | VARCHAR2(20) | | Contact phone number |

## DEPARTMENTS Table
| Column | Type | Constraints | Purpose |
|--------|------|-------------|---------|
| DEPT_ID | NUMBER(5) | PK, NOT NULL | Department identifier |
| DEPT_NAME | VARCHAR2(100) | NOT NULL, UNIQUE | Department name |

## FEEDBACK Table
| Column | Type | Constraints | Purpose |
|--------|------|-------------|---------|
| FEEDBACK_ID | NUMBER(10) | PK, NOT NULL | Unique feedback ID |
| PATIENT_ID | NUMBER(10) | FK → PATIENTS | Patient giving feedback |
| DEPT_ID | NUMBER(5) | FK → DEPARTMENTS | Department receiving feedback |
| RATING | NUMBER(1) | CHECK (1-5) | 1=Poor to 5=Excellent |
| COMMENTS | VARCHAR2(500) | | Patient comments |
| STATUS | VARCHAR2(20) | DEFAULT 'PENDING' | Current status |
| FEEDBACK_DATE | DATE | DEFAULT SYSDATE | Date submitted |

## AUDIT_LOG Table
| Column | Type | Constraints | Purpose |
|--------|------|-------------|---------|
| AUDIT_ID | NUMBER(10) | PK, NOT NULL | Audit record ID |
| FEEDBACK_ID | NUMBER(10) | FK → FEEDBACK | Related feedback |
| ACTION | VARCHAR2(10) | CHECK(INSERT/UPDATE/DELETE) | Operation type |
| USER_NAME | VARCHAR2(50) | | User performing operation |
| ACTION_DATE | TIMESTAMP | DEFAULT SYSTIMESTAMP | When operation occurred |

## HOLIDAYS Table
| Column | Type | Constraints | Purpose |
|--------|------|-------------|---------|
| HOLIDAY_ID | NUMBER(5) | PK, NOT NULL | Holiday identifier |
| HOLIDAY_NAME | VARCHAR2(100) | NOT NULL | Name of holiday |
| HOLIDAY_DATE | DATE | NOT NULL, UNIQUE | Date of holiday |
| IS_ACTIVE | CHAR(1) | DEFAULT 'Y' | Active status |

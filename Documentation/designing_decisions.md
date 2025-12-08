# Designing Decisions

## 1. Database Design Decisions
### Normalization Level: 3NF
**Decision:** Implement Third Normal Form
**Reason:** Eliminates data redundancy, ensures data integrity
**Impact:** More tables but better data quality

### Table Structure
**Decision:** Separate PATIENTS, DEPARTMENTS, FEEDBACK tables
**Reason:** Allows one patient to give multiple feedback to multiple departments
**Impact:** Flexible relationships, scalable design

## 2. PL/SQL Implementation Decisions
### Business Rule Enforcement
**Decision:** Implement via triggers rather than application code
**Reason:** Ensures rules enforced at database level
**Impact:** Cannot bypass rules even with direct SQL access

### Audit Trail
**Decision:** Log all DML operations in AUDIT_LOG
**Reason:** Security and compliance requirements
**Impact:** Increased storage but complete traceability

## 3. Performance Decisions
### Indexing Strategy
**Decision:** Primary keys indexed automatically
**Reason:** Fast lookup for common queries
**Impact:** Better query performance

### Sequence Usage
**Decision:** Use sequences for all primary keys
**Reason:** Ensures uniqueness, better performance than MAX()+1
**Impact:** Scalable ID generation

## 4. Security Decisions
### Weekday/Holiday Restriction
**Decision:** Block operations on weekdays and holidays
**Reason:** Business requirement for controlled updates
**Impact:** Limits when changes can be made

### User Tracking
**Decision:** Store USER in AUDIT_LOG
**Reason:** Accountability for all changes
**Impact:** Can track who made what changes

## 5. Future Considerations
### Scalability
**Decision:** Design for 10,000+ feedback records
**Reason:** Hospital may have high volume
**Impact:** Indexes and partitioning considered

### Extensibility
**Decision:** Modular PL/SQL code
**Reason:** Easy to add new features
**Impact:** Can extend without redesign

-- Creating Procedure 1 ADD_FEEDBACK

CREATE OR REPLACE PROCEDURE ADD_FEEDBACK(
    p_patient_id IN NUMBER,
    p_dept_id IN NUMBER,
    p_rating IN NUMBER,
    p_comments IN VARCHAR2
) AS
    v_feedback_id NUMBER;
    v_patient_name VARCHAR2(100);
    v_dept_name VARCHAR2(100);
BEGIN
    SELECT FEEDBACK_SEQ.NEXTVAL INTO v_feedback_id FROM DUAL;
    
    SELECT PATIENT_NAME INTO v_patient_name FROM PATIENTS WHERE PATIENT_ID = p_patient_id;
    SELECT DEPT_NAME INTO v_dept_name FROM DEPARTMENTS WHERE DEPT_ID = p_dept_id;
    
    INSERT INTO FEEDBACK (FEEDBACK_ID, PATIENT_ID, DEPT_ID, RATING, COMMENTS)
    VALUES (v_feedback_id, p_patient_id, p_dept_id, p_rating, p_comments);
    
    COMMIT;
    

    DBMS_OUTPUT.PUT_LINE('═' || RPAD('', 40, '═') || '═');
    DBMS_OUTPUT.PUT_LINE(' FEEDBACK SUCCESSFULLY ADDED');
    DBMS_OUTPUT.PUT_LINE('═' || RPAD('', 40, '═') || '═');
    DBMS_OUTPUT.PUT_LINE(' Patient: ' || v_patient_name);
    DBMS_OUTPUT.PUT_LINE(' Department: ' || v_dept_name);
    DBMS_OUTPUT.PUT_LINE(' Rating: ' || p_rating || '/5');
    DBMS_OUTPUT.PUT_LINE(' Comments: ' || p_comments);
    DBMS_OUTPUT.PUT_LINE(' Feedback ID: FB-' || v_feedback_id);
    DBMS_OUTPUT.PUT_LINE('═' || RPAD('', 40, '═') || '═');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid Patient ID or Department ID');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END ADD_FEEDBACK;
/

-- Creating Procedure 2 UPDATE_FEEDBACK_STATUS
  
CREATE OR REPLACE PROCEDURE UPDATE_FEEDBACK_STATUS(
    p_feedback_id IN NUMBER,
    p_new_status IN VARCHAR2
) AS
    v_old_status VARCHAR2(20);
BEGIN
    SELECT STATUS INTO v_old_status
    FROM FEEDBACK
    WHERE FEEDBACK_ID = p_feedback_id;
    
    UPDATE FEEDBACK 
    SET STATUS = p_new_status
    WHERE FEEDBACK_ID = p_feedback_id;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE(' Status updated!');
    DBMS_OUTPUT.PUT_LINE('   Feedback ID: ' || p_feedback_id);
    DBMS_OUTPUT.PUT_LINE('   From: ' || v_old_status);
    DBMS_OUTPUT.PUT_LINE('   To: ' || p_new_status);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Feedback ID not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END UPDATE_FEEDBACK_STATUS;
/

-- Creating Procedure 3 GET_DEPT_STATS
  
CREATE OR REPLACE PROCEDURE GET_DEPT_STATS(
    p_dept_id IN NUMBER
) AS
    v_total_feedback NUMBER;
    v_avg_rating NUMBER;
    v_dept_name VARCHAR2(100);
BEGIN
    SELECT DEPT_NAME INTO v_dept_name
    FROM DEPARTMENTS WHERE DEPT_ID = p_dept_id;
    
    SELECT COUNT(*), AVG(RATING)
    INTO v_total_feedback, v_avg_rating
    FROM FEEDBACK WHERE DEPT_ID = p_dept_id;
    
    DBMS_OUTPUT.PUT_LINE('DEPARTMENT STATISTICS');
    DBMS_OUTPUT.PUT_LINE('══');
    DBMS_OUTPUT.PUT_LINE('Department: ' || v_dept_name);
    DBMS_OUTPUT.PUT_LINE('Total Feedback: ' || v_total_feedback);
    DBMS_OUTPUT.PUT_LINE('Average Rating: ' || ROUND(NVL(v_avg_rating, 0), 2) || '/5');
    
    IF v_avg_rating IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Status: No feedback yet');
    ELSIF v_avg_rating >= 4 THEN
        DBMS_OUTPUT.PUT_LINE('Status: Excellent');
    ELSIF v_avg_rating >= 3 THEN
        DBMS_OUTPUT.PUT_LINE('Status: Good');
    ELSIF v_avg_rating >= 2 THEN
        DBMS_OUTPUT.PUT_LINE('Status: Needs Improvement');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Status: Poor - Action Required');
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Department ID not found');
END GET_DEPT_STATS;
/

-- Creating Procedure 4 GENERATE_SIMPLE_REPORT

CREATE OR REPLACE PROCEDURE GENERATE_SIMPLE_REPORT AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('FEEDBACK REPORT');
    DBMS_OUTPUT.PUT_LINE('═');
    DBMS_OUTPUT.PUT_LINE('ID  | Patient  | Department   | Rating | Status');
    DBMS_OUTPUT.PUT_LINE('----|----------|--------------|--------|-------');
    
    FOR rec IN (
        SELECT F.FEEDBACK_ID, P.PATIENT_NAME, D.DEPT_NAME, F.RATING, F.STATUS
        FROM FEEDBACK F
        JOIN PATIENTS P ON F.PATIENT_ID = P.PATIENT_ID
        JOIN DEPARTMENTS D ON F.DEPT_ID = D.DEPT_ID
        ORDER BY F.FEEDBACK_DATE DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            LPAD(rec.FEEDBACK_ID, 3) || ' | ' ||
            RPAD(rec.PATIENT_NAME, 16) || ' | ' ||
            RPAD(rec.DEPT_NAME, 12) || ' | ' ||
            LPAD(rec.RATING, 6) || ' | ' ||
            rec.STATUS
        );
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('══');
    
    DECLARE
        v_total NUMBER;
        v_pending NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_total FROM FEEDBACK;
        SELECT COUNT(*) INTO v_pending FROM FEEDBACK WHERE STATUS = 'PENDING';
        
        DBMS_OUTPUT.PUT_LINE('SUMMARY: ' || v_total || ' total feedback, ' || 
                           v_pending || ' pending review');
    END;
    
END GENERATE_SIMPLE_REPORT;
/

-- Creating Procedure 5 ARCHIVE_OLD_RECORDS

CREATE OR REPLACE PROCEDURE ARCHIVE_OLD_RECORDS(
    p_days_old IN NUMBER DEFAULT 30
) AS
    v_count NUMBER;
BEGIN
    UPDATE FEEDBACK 
    SET STATUS = 'ARCHIVED'
    WHERE STATUS = 'RESOLVED'
      AND FEEDBACK_DATE < SYSDATE - p_days_old;
    
    v_count := SQL%ROWCOUNT;
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Archive complete!');
    DBMS_OUTPUT.PUT_LINE('Archived ' || v_count || ' records');
    DBMS_OUTPUT.PUT_LINE('Older than ' || p_days_old || ' days');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END ARCHIVE_OLD_RECORDS;
/

## Verify the procedures created above

SELECT object_name, status 
FROM user_objects 
WHERE object_type = 'PROCEDURE'
ORDER BY object_name;

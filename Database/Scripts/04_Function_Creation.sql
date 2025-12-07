-- Creating Function 1 CALCULATE_AVG_RATING

CREATE OR REPLACE FUNCTION CALCULATE_AVG_RATING(
    p_dept_id IN NUMBER
) RETURN NUMBER AS
    v_avg_rating NUMBER;
BEGIN
    SELECT AVG(RATING)
    INTO v_avg_rating
    FROM FEEDBACK
    WHERE DEPT_ID = p_dept_id;
    
    RETURN ROUND(NVL(v_avg_rating, 0), 2);
END CALCULATE_AVG_RATING;
/

-- Creating Function 2 VALIDATE_PATIENT
  
CREATE OR REPLACE FUNCTION VALIDATE_PATIENT(
    p_patient_id IN NUMBER
) RETURN VARCHAR2 AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM PATIENTS
    WHERE PATIENT_ID = p_patient_id;
    
    IF v_count > 0 THEN
        RETURN 'VALID';
    ELSE
        RETURN 'INVALID - Patient not found';
    END IF;
END VALIDATE_PATIENT;
/

-- Creating Function 3 COUNT_FEEDBACK_BY_STATUS
  
CREATE OR REPLACE FUNCTION COUNT_FEEDBACK_BY_STATUS(
    p_status IN VARCHAR2
) RETURN NUMBER AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM FEEDBACK
    WHERE STATUS = p_status;
    
    RETURN NVL(v_count, 0);
END COUNT_FEEDBACK_BY_STATUS;
/

-- Creating Function 4 GET_RATING_CATEGORY
  
CREATE OR REPLACE FUNCTION GET_RATING_CATEGORY(
    p_rating IN NUMBER
) RETURN VARCHAR2 AS
BEGIN
    IF p_rating = 5 THEN
        RETURN 'Excellent';
    ELSIF p_rating = 4 THEN
        RETURN 'Very Good';
    ELSIF p_rating = 3 THEN
        RETURN 'Good';
    ELSIF p_rating = 2 THEN
        RETURN 'Fair';
    ELSIF p_rating = 1 THEN
        RETURN 'Poor';
    ELSE
        RETURN 'Invalid Rating';
    END IF;
END GET_RATING_CATEGORY;
/  
  
##Verifying the functions created above

SELECT object_name, status 
FROM user_objects 
WHERE object_type = 'FUNCTION'
ORDER BY object_name;

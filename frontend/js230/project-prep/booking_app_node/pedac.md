# Ex 5

## Problem

1. Create a form for a student to book a schedule
  - Inputs: `select` list of schedules and a student's email
  - Logic:
    - Schedules: insert `option` elements based on the available schedules (through a `GET` request)
      - Available schedules lack a "student_email" value
    - Email: cross reference with the emails of existing students (`GET` request for student details)
      - If student doesn't exist:
        - Raise an alert ("Student does not exist, booking_sequence: XXXXX")
        - Show form to create student
        - When the student is successful created alert both that (`request.response`) and the booking ("Booked")
      - If student exists
        - Alert ("Booked")

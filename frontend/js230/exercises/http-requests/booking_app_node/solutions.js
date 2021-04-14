// Get the number of staff members

const staff = new XMLHttpRequest();
staff.open('GET', '/api/staff_members');
staff.send();

let staffJson = JSON.parse(staff.response);
let numberOfStaff = staffJson.length // Answer is 5

// Number of students
const students = new XMLHttpRequest();
students.open('GET', '/api/students');
students.send();

let studentsJson = JSON.parse(students.response);
let numberOfStudents = studentsJson.length // Answer is 5

// Number of schedules
const schedules = new XMLHttpRequest();
schedules.open('GET', '/api/schedules');
schedules.send();

let schedulesJson = JSON.parse(schedules.response);
let numberOfSchedules = schedulesJson.length // Answer is 9

// Number of schedules with booking

let bookedSchedules = schedulesJson.filter(schedule => schedule.student_email !== null);

bookedSchedules.length // Answer is 3

// Do all staff have schedules? First: staff ids; then: retrieve their schedules

// Manual check of data: no, only staffs with ids 1-3 have schedules
// I.e., staff with ids 4-5 do not


// Did all students book a schedule?
// Manual check of data: no, only 3 did
// The 2 who did not had emails: enrico_prosacco@ortiz.com and esmeralda.weber@huel.biz"


/*

Problem: get all the schedules
- If one+ are available: return key value pairs
  - Key: staff {id}
  - Value: number of schedules per staff
- If 0 schedules: alert the user no schedules are available for booking
- If the request takes more than 5 seconds cancel the request and inform the user
- Inform the user of the request's retrieval regardless of its success or failure (timeout)

*/

function getSchedules() {
  const schedules = new XMLHttpRequest();
  schedules.open('GET', '/api/schedules');
  schedules.timeout = 5000;
  schedules.send();

  let schedulesJson = JSON.parse(schedules.response);

  if (schedulesJson.length === 0) {
    console.log('There are no schedules');
  } else {

  }

  console.log('This is the end of the request');
}
// https://launchschool.com/exercises/2a95a258

document.addEventListener('DOMContentLoaded', () => {
  (function loadList() {
    const requestAvailableSchedules = new XMLHttpRequest();
    requestAvailableSchedules.open('GET', '/api/schedules');
    requestAvailableSchedules.responseType = 'json';
    requestAvailableSchedules.timeout = 5000;
    requestAvailableSchedules.send();

    requestAvailableSchedules.addEventListener('load', () => {
      const scheduleJson = requestAvailableSchedules.response;
      const availableSchedules = scheduleJson.filter(obj => !obj.student_email);

      const requestStaffData = new XMLHttpRequest();
      requestStaffData.open('GET', '/api/staff_members');
      requestStaffData.responseType = 'json';
      requestStaffData.send();

      requestStaffData.addEventListener('load', () => {
        const staffJson = requestStaffData.response;
        const selectNode = document.querySelector('select');
        selectNode.querySelector('option').innerText = 'Select a teacher';

        availableSchedules.forEach(obj => {
          let result = { date: obj.date, time: obj.time, staff_id: obj.staff_id };
          result.staff_name = staffJson.filter(staff => staff.id === obj.staff_id)[0].name;

          let option = document.createElement('option');
          option.value = obj.id;
          option.innerText = `${result.staff_name} | ${obj.date} | ${obj.time}`;
          selectNode.appendChild(option);
        });

      })
    });

    requestAvailableSchedules.addEventListener('timeout', () => {
      alert(`Things are slower than usual on our end, please try again later.`)
    });
  })()

  function submitSchedule() {
    const submitSchedule = document.getElementById('submit-schedule');

    submitSchedule.addEventListener('submit', event => {
      event.preventDefault();
      const inputEmail = document.querySelector('form#submit-schedule input[type=email]').value;

      const request = new XMLHttpRequest();
      request.open('GET', '/api/students');
      request.responseType = 'json';
      request.send();

      request.addEventListener('load', () => {
        const studentData = request.response;
        const student = studentData.filter(student => student.email === inputEmail);

        if (!student) {
        } else {
          const inputFormData = new FormData(document.getElementById('submit-schedule'));
          const inputJson = Object.fromEntries(inputFormData);
          const stringifiedInput = JSON.stringify(inputJson);
          const bookingRequest = new XMLHttpRequest();
          bookingRequest.open('POST', '/api/bookings');
          bookingRequest.setRequestHeader('Content-Type', 'application/json');
          bookingRequest.send(stringifiedInput);

          bookingRequest.addEventListener('load', event => {
            console.log(stringifiedInput);
            console.log(bookingRequest);
            console.log(bookingRequest.status);
            console.log(bookingRequest.response);

            if (bookingRequest.status === 404) {
              const createStudentForm = document.getElementById('create-student');
              const response = bookingRequest.response.split(' ');
              const bookingSequence = response[response.length - 1];

              createStudentForm.classList.remove('hidden');
              createStudentForm.querySelector('input[name=email]').value = inputEmail;
              createStudentForm.querySelector('input[name=booking_sequence]').value = bookingSequence;
            } else if (bookingRequest.status === 201) {
              alert('Schedule booked');
            }
          })
        }
      });
    })
  }

  function submitStudent() {
    const formCreateStudent = document.querySelector('#create-student form');

    formCreateStudent.addEventListener('submit', event => {
      event.preventDefault();
      const formData = new FormData(formCreateStudent);
      const jsonData = Object.fromEntries(formData);
      const stringifiedJson = JSON.stringify(jsonData);

      const request = new XMLHttpRequest();
      request.open('POST', '/api/students');
      request.setRequestHeader('Content-Type', 'application/json');
      request.send(stringifiedJson);

      request.addEventListener('load', event => {
        if (request.status === 404) {
          alert(request.response);
        } else {
        }
      });
    })

  }

});
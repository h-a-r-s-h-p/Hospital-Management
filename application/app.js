const express = require('express')
const http = require('http');
const bodyParser = require('body-parser');
const fs = require('fs');
var mysql = require('mysql');
const app = express();
const port = 4000;
var appt_details

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password",
  database: "hospital_management"
});

app.listen(port, () => {
  console.log(`application listening at http://localhost:${port}`)
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});

var dlist;
var Emp_ID;
var Emp_route;
var Emp_html;
var Patient_id;
var Do_ID;
var plist;

const jsdom = require("jsdom");
const { resolve4 } = require('dns');

app.use(express.static(__dirname))
app.use(bodyParser.urlencoded({ extended: true })); 

app.get('/',(req,res)=>{
  res.sendFile('src/mainpage.html',{root:"."})
})

app.get('/elogin',(req,res)=>{
  clear_err('src/Employee_login.html');
  clear_err('src/Patient_login.html');
  res.sendFile('src/Employee_login.html',{root:"."})
})

app.get('/plogin',(req,res)=>{
  clear_err('src/Employee_login.html');
  clear_err('src/Patient_login.html');
  res.sendFile('src/Patient_login.html',{root:"."})
})

app.get('/main',(req,res)=>{
  clear_err('src/Employee_login.html');
  clear_err('src/Patient_login.html');
  res.sendFile('src/mainpage.html',{root:"."})
})

app.get('/appt',(req,res)=>{
  clear_err('src/Employee_login.html');
  clear_err('src/Patient_login.html');
  con.query('select Doctor_ID, name, Qualification, Specialization  from Doctor natural join Employees where present=\'Present\';',
  function(err,result,fields){
  const res = Object.values(JSON.parse(JSON.stringify(result)));
  dlist = res;
  
  fs.readFile('src/appointment.html', 'utf8', function(error, data) {
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    var str = "";
    dlist.forEach((v)=> str += "<option><p>"+v.Doctor_ID.toString()+" "+v.name+" "+v.Specialization+"</p></option>")
    jquery("select").empty();
    jquery("select").append(str);
    const content = dom.window.document.querySelector("select");
    fs.writeFile('src/appointment.html', dom.serialize(), err => {
  });
  });
});
  res.sendFile('src/appointment.html',{root:"."});
})

app.get('/success',(req,res)=>{
  pid_q = "select Patient_ID from appointment order by Patient_ID desc limit 1;";
  con.query(pid_q,
    function(err,result,fields){
      const PID = Object.values(JSON.parse(JSON.stringify(result)))[0].Patient_ID;
      fs.readFile('src/success.html', 'utf8', function(error, data) {
        const dom = new jsdom.JSDOM(data);
        const jquery = require('jquery')(dom.window);
        jquery("p").empty();
        jquery("p").append('Your Patient ID is '+PID.toString());
        const content = dom.window.document.querySelector("p");
        fs.writeFile('src/success.html', dom.serialize(), err => {
          console.log('PID inserted successfully');
          res.sendFile('src/success.html',{root:"."})
      });
      });
  });
})

app.get('/patient',(req,res)=>{
  res.sendFile('src/patient.html',{root:"."})
})

app.post('/appt',function(req,res){
  appt_details = req.body
  pname = appt_details.name;
  sex = appt_details.sex;
  addr = appt_details.address;
  contact = appt_details.contact;
  date = appt_details.date_input;
  did = appt_details.Select1.split(" ")[0];
  console.log(did);
  sql_q = "call add_appointment(\'"+pname+"\',\'"+sex+"\',\'"+date+"\',"+contact+",\'"+addr;
  sql_q += "\',"+did+");";
  
  con.query(sql_q,
    function(err,result,fields){
    res.redirect('/success')
  });
});

function clear_err(html_file){
  fs.readFile(html_file, 'utf8', function(error, data) {
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    jquery("#errmsg").empty();
    fs.writeFile(html_file, dom.serialize(), err => {
      console.log('err removed successfully');
  });
  });
}

function raise_err(html_file){
  fs.readFile(html_file, 'utf8', function(error, data) {
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    code = '\n<p><b>!</b> Invalid Employee ID or password</p>\n';
    jquery("#errmsg").empty();
    jquery("#errmsg").append(code);
    fs.writeFile(html_file, dom.serialize(), err => {
      console.log('err raised successfully');
  });
  });
}

app.post('/elogin', function(req,res){
  EID = req.body.EID;
  password = req.body.Password;
  sql_q = 'select * from Employees natural join Department where Employee_ID ='+EID.toString()+';';
  con.query(sql_q,
    function(err,result,fields){
      len = result.length;
      var path = '/elogin';
      if(len == 1){
        query_res = Object.values(JSON.parse(JSON.stringify(result)))[0];
        Emp_ID = EID;
        E_password = query_res.password;
        Status = query_res.present;
        name = query_res.Name;
        Email = query_res.E_mail;
        Sex = query_res.Sex;
        Address = query_res.Address;
        contact = query_res.Contact;
        DID = query_res.Department_ID;
        Dname = query_res.Department_name;
        if(E_password == password){
          Dept_code = Math.floor(EID/1000 % 10);
          clear_err('src/Employee_login.html');
          clear_err('src/Patient_login.html');
          if(Dept_code === 1){  
            Emp_route = '/nurse';
            Emp_html = 'src/nurse.html';
            update_file(EID,Status,DID,Dname,name,Sex,Address,contact,Email);
          }else{
            if(Dept_code === 2){
              Emp_route = '/doctor';
              Emp_html = 'src/doctor.html';
              update_file(EID,Status,DID,Dname,name,Sex,Address,contact,Email);
            }else{
              Emp_route = '/receptionist';
              Emp_html = 'src/receptionist.html';
              update_file(EID,Status,DID,Dname,name,Sex,Address,contact,Email);
            }
          }
          path = Emp_route;
        }else{
          raise_err('src/Employee_login.html');
        }
      }else{
        raise_err('src/Employee_login.html');
      }
      res.redirect(path);
  });
});

app.post("/logout",(req, res) => {
  res.redirect('/main');
});

app.get("/doctor", (req, res) => {
  sql_q = 'select * from Doctor where Employee_ID = '+Emp_ID.toString()+';';
  con.query(sql_q,
    function(err,result,fields){
      out = Object.values(JSON.parse(JSON.stringify(result)));
      html_file = 'src/doctor.html';
      fs.readFile(html_file, 'utf8', function(error, data) {
        const dom = new jsdom.JSDOM(data);
        const jquery = require('jquery')(dom.window);
        jquery("#appt").empty();
        jquery("#success").empty();
        jquery("#success_admit").empty();
        code = '<button type="toggle" class="btn btn-primary btn-block disabled">Mark Appointment</button>';
        jquery("#appt_mark").empty();
        jquery("#appt_mark").append(code);
        code = '<button type="toggle" class="btn btn-primary btn-block disabled">Admit patient</button>';
        jquery("#admit").empty();
        jquery("#admit").append(code);
        fs.writeFile(html_file, dom.serialize(), err => { 
          console.log('appt file erased successfully');
        });
      });
      Do_ID = out[0].Doctor_ID;
      res.sendFile('src/doctor.html',{root:"."})
    });
});

app.get("/nurse", (req, res) => {
  html_file = 'src/nurse.html';
  fs.readFile(html_file, 'utf8', function(error, data) {
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    jquery("#msg").empty();
    jquery("#rid").empty();
    jquery("#rtype").empty();
    jquery("#wtype").empty();
    jquery("#floor").empty();
    fs.writeFile(html_file, dom.serialize(), err => { 
      console.log('nurse file erased successfully');
    });
  });
  res.sendFile('src/nurse.html',{root:"."}) 
});

function nurse_room_write(result){
  html_file = 'src/nurse.html';
      fs.readFile(html_file, 'utf8', function(error, data) {
      const dom = new jsdom.JSDOM(data);
      const jquery = require('jquery')(dom.window);
      code = '\n<p><b>No room scheduled</b></p>\n';
      jquery("#msg").empty();
      jquery("#msg").append(code);
      console.log(result);
      if(result.length !== 0){
        out = Object.values(JSON.parse(JSON.stringify(result)));
        rid = out[0].Room_ID;
        rtype = out[0].Room_Type;
        wtype = out[0].Ward_Type;
        floor = out[0].Floor;
        console.log(rid,rtype,wtype,floor);
        jquery("#msg").empty();
        jquery("#rid").empty();
        jquery("#rtype").empty();
        jquery("#wtype").empty();
        jquery("#floor").empty();
        code = '\n<label for="rid">Room ID</label>\n';
        code += '<input class="form-control" type="text" placeholder="'+rid+'" readonly=""></input>\n';
        jquery("#rid").append(code);
        code = '\n<label for="rtype">Room type</label>\n';
        code += '<input class="form-control" type="text" placeholder="'+rtype+'" readonly=""></input>\n';
        jquery("#rtype").append(code);
        code = '\n<label for="wtype">Ward</label>\n';
        code += '<input class="form-control" type="text" placeholder="'+wtype+'" readonly=""></input>\n';
        jquery("#wtype").append(code);
        code = '\n<label for="floor">Floor</label>\n';
        code += '<input class="form-control" type="text" placeholder="'+floor+'" readonly=""></input>\n';
        jquery("#floor").append(code);
      }
      fs.writeFile(html_file, dom.serialize(), err => { 
        console.log('nurse scheduled successfully');
      });
    });
}

app.get("/receptionist", (req, res) => { 
  res.sendFile('src/receptionist.html',{root:"."});
});

app.post("/status",(req, res) => {
  sql_q = 'select present from Employees where Employee_ID ='+Emp_ID.toString()+';';
  console.log(Emp_ID);
  con.query(sql_q,
  function(err,result,fields){
    query_res = Object.values(JSON.parse(JSON.stringify(result)))[0];
    Status = query_res.present;
    if(Status == 'Present'){
      sqlq = 'call drop_attendance('+Emp_ID.toString()+');';
    }else{
      sqlq = 'call mark_attendance('+Emp_ID.toString()+');';
    }
    con.query(sqlq,
      function(err,resu,field){
        console.log(Emp_html)
        fs.readFile(Emp_html, 'utf8', function(error, data) {
          const dom = new jsdom.JSDOM(data);
          const jquery = require('jquery')(dom.window);
          code = '\n<label for="status">Status (click to change status)</label>\n';
          if(Status == "Present"){
            code += '<button type="toggle" class="btn btn-danger btn-block" id="status_toggle" value="Absent">'+'Absent'+'</button>\n';
          }else{
            code += '<button type="toggle" class="btn btn-success btn-block" id="status_toggle" value="Present">'+'Present'+'</button>\n';
          }
          jquery("#status").empty();
          jquery("#status").append(code);
          fs.writeFile(Emp_html, dom.serialize(), err => {
            console.log('status changed successfully');
          });
        });
        res.redirect(Emp_route);
      });
  }); 
});

app.post("/schedule", (req,res) => {
  sql_q = 'select * from Nurse_schedule where Employee_ID = '+Emp_ID.toString()+';';
  con.query(sql_q,
    function(err,result,fields){
    nurse_room_write(result);
    res.redirect('/nurse');
  });
});

function update_file(EID,Status,DID,Dname,name,Sex,Address,contact,Email){
  fs.readFile(Emp_html, 'utf8', function(error, data) {
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    // for employee ID
    var code = '\n<label for="eID">Employee ID</label>\n'
    code += '<input class="form-control" type="text" placeholder="'+EID.toString()+'" readonly></input>\n';
    jquery("#did").empty();
    jquery("#did").append(code);
    // for name
    code = '\n<label for="name">Name</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+name+'" readonly=""></input>\n';
    jquery("#name").empty();
    jquery("#name").append(code);
    // for DID-Dname
    code = '\n<label for="department">Department</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+DID+'-'+Dname+'" readonly=""></input>\n';
    jquery("#department").empty();
    jquery("#department").append(code);
    // for address
    code = '\n<label for="address">Address</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+Address+'" readonly=""></input>\n';
    jquery("#address").empty();
    jquery("#address").append(code);
    // for sex
    code = '\n<label for="sex">Sex</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+Sex+'" readonly=""></input>\n';
    jquery("#sex").empty();
    jquery("#sex").append(code);
    // for email
    code = '\n<label for="email">Email</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+Email+'" readonly=""></input>\n';
    jquery("#email").empty();
    jquery("#email").append(code);
    // for contact
    code = '\n<label for="contact">Contact</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+contact+'" readonly=""></input>\n';
    jquery("#contact").empty();
    jquery("#contact").append(code);
    // for status
    code = '\n<label for="status">Status (click to change status)</label>\n';
    if(Status == "Present"){
      code += '<button type="toggle" class="btn btn-success btn-block" id="status_toggle">'+Status+'</button>\n';
    }else{
      code += '<button type="toggle" class="btn btn-danger btn-block" id="status_toggle">'+Status+'</button>\n';
    }
    jquery("#status").empty();
    jquery("#status").append(code);
    fs.writeFile(Emp_html, dom.serialize(), err => {
      console.log('PID inserted successfully');
  });
  });
}

app.post('/plogin', function(req,res){
  PID = req.body.PID;
  sql_bill = 'select * from Bill natural join (select * from InPayment union select * from OutPayment) as p';
  sql_q = 'select Doctor_ID, doctor_name from Patient_doctor where Patient_ID ='+PID.toString()+';';
  con.query(sql_q,
    function(err,result,fields){
      len = result.length;
      var path = '/plogin';
      if(len == 1){
        path = '/patient';
        out = Object.values(JSON.parse(JSON.stringify(result)))[0];
        dname = out.doctor_name;
        did = out.Doctor_ID;
        Patient_id = PID;
        html_file = 'src/patient.html';
        if(Math.floor(PID/10000 % 10)==3){
          sql_appt = 'select * from appointment where Patient_ID = '+PID.toString()+';';
          sql_detail = 'select * from OutPatient where Patient_ID = ';
          sql_detail += PID.toString()+';';
          con.query(sql_detail,
            function(err,result,fields){
              out = Object.values(JSON.parse(JSON.stringify(result)))[0];
              con.query(sql_appt,
                function(err,resu,fields){
                appt = Object.values(JSON.parse(JSON.stringify(resu)))[0];
                status = 'Done';
                if(resu.length == 1){
                  status = appt.status;
                }
                sql_bill = 'select * from Bill natural join (select * from InPayment union select * from OutPayment) as p where p.Patient_ID = ';
                sql_bill += PID.toString()+';';
                con.query(sql_bill,
                  function(err,result1,fields){
                    out1 = Object.values(JSON.parse(JSON.stringify(result1)))[0];
                    update_out_file(result1.length,out,out1,PID,did,dname,status,html_file);
                    res.redirect('/patient');
                });               
            });
          });
        }else{
          sql_detail = 'select * from InPatient where Patient_ID = ';
          sql_detail += PID.toString()+';';
          console.log(sql_detail);
          con.query(sql_detail,
            function(err,result,fields){
              out = Object.values(JSON.parse(JSON.stringify(result)))[0];
              sql_bill = 'select * from Bill natural join (select * from InPayment union select * from OutPayment) as p where p.Patient_ID = ';
              sql_bill += PID.toString()+';';
              con.query(sql_bill,
                function(err,result1,fields){
                  out1 = Object.values(JSON.parse(JSON.stringify(result1)))[0];
                  update_in_file(result1.length,out,out1,PID,did,dname,html_file);
                  res.redirect('/patient');
              });
          });
        }
        
      }else{
        raise_err('src/Patient_login.html');
        res.redirect('/plogin');
      } 
  });
});

function update_out_file(reslen,out,out1,pid,did,dname,status,html_file){
  fs.readFile(html_file, 'utf8', function(error, data) {
    name = out.Name;
    sex = out.Sex;
    contact = out.Contact;
    addr = out.Address;
    date = out.Date_Visited.split('T')[0];
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    jquery("#medication").empty();
    jquery("#facility").empty();
    jquery("#room").empty();
    code = '\n<label for="pid">Patient ID</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+pid+'" readonly=""></input>\n';
    jquery("#pid").empty();
    jquery("#pid").append(code);
    code = '\n<label for="name">Name</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+name+'" readonly=""></input>\n';
    jquery("#name").empty();
    jquery("#name").append(code);
    code = '\n<label for="address">Address</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+addr+'" readonly=""></input>\n';
    jquery("#address").empty();
    jquery("#address").append(code);
    code = '\n<label for="sex">Sex</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+sex+'" readonly=""></input>\n';
    jquery("#sex").empty();
    jquery("#sex").append(code);
    code = '\n<label for="contact">Contact</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+contact+'" readonly=""></input>\n';
    jquery("#contact").empty();
    jquery("#contact").append(code);
    code = '\n<label for="did">Doctor ID</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+did+'" readonly=""></input>\n';
    jquery("#did").empty();
    jquery("#did").append(code);
    code = '\n<label for="dname">Doctor name</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+dname+'" readonly=""></input>\n';
    jquery("#dname").empty();
    jquery("#dname").append(code);
    code = '\n<label for="status">Appointment status</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+status+'" readonly=""></input>\n';
    jquery("#status").empty();
    jquery("#status").append(code);
    code = '\n<label for="date">Appointment date</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+date+'" readonly=""></input>\n';
    jquery("#date").empty();
    jquery("#date").append(code);
    jquery("#ddate").empty();
    if(reslen == 0){
      jquery("#rid").empty();
      jquery("#tid").empty();
      jquery("#mode").empty();
      jquery("#tdate").empty();
      jquery("#amt").empty();
    }else{
      rid = out1.Reciept_ID;
      tid = out1.Transaction_ID;
      tdate = out1.Transaction_Date.split('T')[0];
      amt = out1.Amount;
      mode = out1.Mode_of_Payment;
      jquery("#rid").empty();
      jquery("#rid").append(code);
      code = '\n<label for="tid">Transaction ID</label>\n';
      code += '<input class="form-control" type="text" placeholder="'+tid+'" readonly=""></input>\n';
      jquery("#tid").empty();
      jquery("#tid").append(code);
      code = '\n<label for="mode">Mode of Payment</label>\n';
      code += '<input class="form-control" type="text" placeholder="'+mode+'" readonly=""></input>\n';
      jquery("#mode").empty();
      jquery("#mode").append(code);
      code = '\n<label for="tdate">Transaction Date</label>\n';
      code += '<input class="form-control" type="text" placeholder="'+tdate+'" readonly=""></input>\n';
      jquery("#tdate").empty();
      jquery("#tdate").append(code);
      code = '\n<label for="amt">Amount</label>\n';
      code += '<input class="form-control" type="text" placeholder="'+amt+'" readonly=""></input>\n';
      jquery("#amt").empty();
      jquery("#amt").append(code);
    }
    fs.writeFile(html_file, dom.serialize(), err => { 
      console.log('Out file written successfully');
    });
 });
}

function update_in_file(reslen,out,out1,pid,did,dname,html_file){
  fs.readFile(html_file, 'utf8', function(error, data) {
    name = out.Name;
    sex = out.Sex;
    contact = out.Contact;
    addr = out.Address;
    Adate = out.Date_Admitted.split('T')[0];
    Ddate = out.Date_Discharged.split('T')[0];
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    jquery("#medication").empty();
    jquery("#facility").empty();
    jquery("#room").empty();
    jquery("#status").empty();
    code = '\n<label for="pid">Patient ID</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+pid+'" readonly=""></input>\n';
    jquery("#pid").empty();
    jquery("#pid").append(code);
    code = '\n<label for="name">Name</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+name+'" readonly=""></input>\n';
    jquery("#name").empty();
    jquery("#name").append(code);
    code = '\n<label for="address">Address</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+addr+'" readonly=""></input>\n';
    jquery("#address").empty();
    jquery("#address").append(code);
    code = '\n<label for="sex">Sex</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+sex+'" readonly=""></input>\n';
    jquery("#sex").empty();
    jquery("#sex").append(code);
    code = '\n<label for="contact">Contact</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+contact+'" readonly=""></input>\n';
    jquery("#contact").empty();
    jquery("#contact").append(code);
    code = '\n<label for="did">Doctor ID</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+did+'" readonly=""></input>\n';
    jquery("#did").empty();
    jquery("#did").append(code);
    code = '\n<label for="dname">Doctor name</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+dname+'" readonly=""></input>\n';
    jquery("#dname").empty();
    jquery("#dname").append(code);
    code = '\n<label for="date">Admission date</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+Adate+'" readonly=""></input>\n';
    jquery("#date").empty();
    jquery("#date").append(code);
    code = '\n<label for="ddate">Discharge date</label>\n';
    code += '<input class="form-control" type="text" placeholder="'+Ddate+'" readonly=""></input>\n';
    jquery("#ddate").empty();
    jquery("#ddate").append(code);
    if(reslen == 0){
      jquery("#rid").empty();
      jquery("#tid").empty();
      jquery("#mode").empty();
      jquery("#tdate").empty();
      jquery("#amt").empty();
    }else{
      rid = out1.Reciept_ID;
      tid = out1.Transaction_ID;
      tdate = out1.Transaction_Date.split('T')[0];
      amt = out1.Amount;
      mode = out1.Mode_of_Payment;
      jquery("#rid").empty();
      jquery("#rid").append(code);
      code = '\n<label for="tid">Transaction ID</label>\n';
      code += '<input class="form-control" type="text" placeholder="'+tid+'" readonly=""></input>\n';
      jquery("#tid").empty();
      jquery("#tid").append(code);
      code = '\n<label for="mode">Mode of Payment</label>\n';
      code += '<input class="form-control" type="text" placeholder="'+mode+'" readonly=""></input>\n';
      jquery("#mode").empty();
      jquery("#mode").append(code);
      code = '\n<label for="tdate">Transaction Date</label>\n';
      code += '<input class="form-control" type="text" placeholder="'+tdate+'" readonly=""></input>\n';
      jquery("#tdate").empty();
      jquery("#tdate").append(code);
      code = '\n<label for="amt">Amount</label>\n';
      code += '<input class="form-control" type="text" placeholder="'+amt+'" readonly=""></input>\n';
      jquery("#amt").empty();
      jquery("#amt").append(code);
    }
    fs.writeFile(html_file, dom.serialize(), err => { 
      console.log('IN file wrote successfully');
    });
 });
}

app.post('/facility', function(req,res){
  sql_q = 'select * from Facilities natural join ';
  sql_q += '(select * from InUses union select * from OutUses) as u where Patient_ID = '
  sql_q += Patient_id.toString() + ';';
  con.query(sql_q,
    function(err,result,fields){
      update_facility_file(result);
      // console.log(result);
      res.redirect('/patient');
  });
});

app.post('/medicine', function(req,res){
  sql_q = 'select * from Medicine_log ';
  sql_q += 'where Patient_ID = '
  sql_q += Patient_id.toString() + ';';
  con.query(sql_q,
    function(err,result,fields){
      update_medication_file(result);
      res.redirect('/patient');
  });
});

app.post('/room', function(req,res){
  sql_room = 'select * from Rooms natural join Allocated natural join Supervision ';
  sql_room += 'natural join Nurse natural join Employees where Patient_ID = ';
  sql_room += PID.toString()+';';
  con.query(sql_room,
    function(err,result,fields){
      update_room_file(result);
      res.redirect('/patient');
  });
});

function update_facility_file(obj){
  out = Object.values(JSON.parse(JSON.stringify(obj)));
  console.log(out)
  code = '<table class="table table-striped table-dark">\n';
  code += '<thead><tr><th scope="col">#</th><th scope="col">Facility ID</th><th scope="col">Facility name</th>\n';
  code += '<th scope="col">Cost</th><th scope="col">Room No.</th></tr></thead><tbody>\n'
  var i;
  for(i=0; i<out.length; i++){
    fid = out[i].Facility_ID;
    fname = out[i].Facility_name;
    cost = out[i].Cost;
    rn = out[i].RoomNo;
    code += '<tr><th scope="row">'+(i+1).toString()+'</th><td>'+fid.toString()+'</td><td>'+fname;
    code += '</td><td>'+cost.toString()+'</td><td>'+rn.toString()+'</td></tr>\n';
  }
  code += '</tbody></table>';
  html_file = 'src/patient.html';
  console.log(code);
  fs.readFile(html_file, 'utf8', function(error, data) {
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    jquery("#facility").empty();
    jquery("#facility").append(code);
    fs.writeFile(html_file, dom.serialize(), err => { 
      console.log('IN file wrote successfully');
    });
  });
}

function update_medication_file(obj){
  out = Object.values(JSON.parse(JSON.stringify(obj)));
  console.log(out)
  code = '<table class="table table-striped table-dark">\n';
  code += '<thead><tr><th scope="col">#</th><th scope="col">Code</th><th scope="col">Price</th>\n';
  code += '<th scope="col">Exp. Date</th></tr></thead><tbody>\n'
  var i
  for(i=0; i<out.length; i++){
    mcode = out[i].Code;
    price = out[i].Price;
    edate = out[i].Expr_Date.split('T')[0];
    console.log(mcode,price,edate);
    code += '<tr><th scope="row">'+(i+1).toString()+'</th><td>'+mcode.toString()+'</td><td>'+price.toString()+'</td><td>'+edate+'</td></tr>\n';
  }
  code += '</tbody></table>';
  html_file = 'src/patient.html';
  console.log(code);
  fs.readFile(html_file, 'utf8', function(error, data) {
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    jquery("#medication").empty();
    jquery("#medication").append(code);
    fs.writeFile(html_file, dom.serialize(), err => { 
      console.log('IN file wrote successfully');
    });
  });
}

function update_room_file(obj){
  out = Object.values(JSON.parse(JSON.stringify(obj)));
  console.log(out)
  code = '<table class="table table-striped table-dark">\n';
  code += '<thead><tr><th scope="col">#</th><th scope="col">Room</th><th scope="col">Location</th>\n';
  code += '<th scope="col">Cost</th><th scope="col">Bed ID</th><th scope="col">Nurse</th></tr></thead><tbody>\n'
  var i;
  for(i=0; i<out.length; i++){
    name = out[i].Name;
    nid = out[i].Nurse_ID;
    rid = out[i].Room_ID;
    rtype = out[i].Room_Type;
    floor = out[i].Floor;
    wtype = out[i].Ward_Type;
    charge = out[i].Room_Charges;
    bid = out[i].Bed_ID;
    code += '<tr><th scope="row">'+(i+1).toString()+'</th><td>'+rid.toString()+'-'+rtype+'</td><td>'+' floor-'+floor;
    code += ' '+wtype+' ward</td><td>'+bid.toString()+'</td><td>'+charge.toString()+'</td><td>'+nid.toString()+'-'+name+'</td></tr>\n';
  }
  code += '</tbody></table>';
  html_file = 'src/patient.html';
  console.log(code);
  fs.readFile(html_file, 'utf8', function(error, data) {
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    jquery("#room").empty();
    jquery("#room").append(code);
    fs.writeFile(html_file, dom.serialize(), err => { 
      console.log('IN file wrote successfully');
    });
  });
}

app.post('/dappt', function(req,res){
  sql_appt = 'select * from appointment natural join OutPatient ';
  sql_appt += 'where Doctor_ID = ';
  sql_appt += Do_ID.toString()+';';
  con.query(sql_appt,
    function(err,result,fields){
      update_appt_file(result);
      res.redirect('/doctor');
  });
});

function update_appt_file(obj){
  out = Object.values(JSON.parse(JSON.stringify(obj)));
  console.log(out)
  code = '<table class="table table-striped table-dark">\n';
  code += '<thead><tr><th scope="col">#</th><th scope="col">Patient</th><th scope="col">Sex</th>\n';
  code += '<th scope="col">Contact</th><th scope="col">Appointment Date</th><th scope="col">Status</th></tr></thead><tbody>\n'
  var i;
  plist = []
  for(i=0; i<out.length; i++){
    name = out[i].Name;
    pid = out[i].Patient_ID;
    sex = out[i].Sex;
    contact = out[i].Contact;
    adate = out[i].appt_date.split('T')[0];
    status = out[i].status;
    plist.push(pid);
    code += '<tr><th scope="row">'+(i+1).toString()+'</th><td>'+pid.toString()+'-'+name+'</td><td>'+sex;
    code += '</td><td>'+contact.toString()+'</td><td>'+adate+'</td><td>'+status+'</td></tr>\n';
  }
  code += '</tbody></table>';
  html_file = 'src/doctor.html';
  console.log(plist);
  console.log(code);
  fs.readFile(html_file, 'utf8', function(error, data) {
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    jquery("#appt").empty();
    jquery("#appt").append(code);
    code = '<button type="toggle" class="btn btn-primary btn-block">Mark Appointment</button>';
    jquery("#appt_mark").empty();
    jquery("#appt_mark").append(code);
    code = '<button type="toggle" class="btn btn-primary btn-block">Admit patient</button>';
    jquery("#admit").empty();
    jquery("#admit").append(code);
    fs.writeFile(html_file, dom.serialize(), err => { 
      console.log('appt file wrote successfully');
    });
  });
}

app.post('/mark', function(req,res){
  patientID = parseInt(req.body.pid);
  console.log(plist,patientID,Do_ID);
  if(plist.includes(patientID)){
    sql_q = 'CALL mark_appointment(\''+Do_ID.toString()+'\',\''+patientID.toString()+'\');'
  con.query(sql_q,
    function(err,result,fields){
      raise_success(patientID);
      res.redirect('/doctor');
  });
  }else{
    raise_err_appt();
    res.redirect('/doctor');
  }
});

function raise_success(pid){
  html_file = 'src/doctor.html';
  fs.readFile(html_file, 'utf8', function(error, data) {
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    code = '\n<p>Patient with id '+pid.toString()+' marked successfully</p>\n';
    jquery("#success").empty();
    jquery("#success").append(code);
    fs.writeFile(html_file, dom.serialize(), err => {
      // console.log('err raised successfully');
  });
  });
}

function raise_err_appt(){
  html_file = 'src/doctor.html';
  fs.readFile(html_file, 'utf8', function(error, data) {
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    code = '\n<p><b>!</b> cannot mark</p>\n';
    jquery("#success").empty();
    jquery("#success").append(code);
    fs.writeFile(html_file, dom.serialize(), err => {
      // console.log('err raised successfully');
  });
  });
}

app.post('/admit', function(req,res){
  patientID = parseInt(req.body.pid);
  date = req.body.date_input;
  console.log(patientID,date);
  if(plist.includes(patientID)){
    sql_q = 'CALL admit_patient(\''+patientID.toString()+'\',\''+date+'\');'
    con.query(sql_q,
      function(err,result,fields){
        raise_success_admit(patientID);
        res.redirect('/doctor');
  });
  }else{
    raise_err_admit();
    res.redirect('/doctor');
  }
});

function raise_success_admit(pid){
  html_file = 'src/doctor.html';
  sql_q = 'select Patient_ID from InPatient order by Patient_ID DESC limit 1;';
  con.query(sql_q,
    function(err,result,fields){
      out = Object.values(JSON.parse(JSON.stringify(result)));
      newID = out[0].Patient_ID;
      fs.readFile(html_file, 'utf8', function(error, data) {
        const dom = new jsdom.JSDOM(data);
        const jquery = require('jquery')(dom.window);
        code = '\n<p>Patient with id '+pid.toString()+' admitted successfully ';
        code += 'new InPatient ID is '+newID.toString()+'</p>\n';
        jquery("#success_admit").empty();
        jquery("#success_admit").append(code);
        fs.writeFile(html_file, dom.serialize(), err => {
          // console.log('err raised success_admitfully');
      });
      });
  });
}

function raise_err_admit(){
  html_file = 'src/doctor.html';
  fs.readFile(html_file, 'utf8', function(error, data) {
    const dom = new jsdom.JSDOM(data);
    const jquery = require('jquery')(dom.window);
    code = '\n<p><b>!</b> cannot admit</p>\n';
    jquery("#success_admit").empty();
    jquery("#success_admit").append(code);
    fs.writeFile(html_file, dom.serialize(), err => {
      // console.log('err raised successfully');
  });
  });
}

app.post('/record',function(req,res){
  patientID = parseInt(req.body.pid);
  date = req.body.date_input;
  desc = req.body.desc;
  console.log(patientID,date,desc);
  sql_q = "call insert_record("+Emp_ID+","+patientID+",'"+date+"','"+desc+"');";
  console.log(sql_q);
  Status = 'Absent';
  con.query(sql_q,
      function(err,result,fields){
      fs.readFile(Emp_html, 'utf8', function(error, data) {
        const dom = new jsdom.JSDOM(data);
        const jquery = require('jquery')(dom.window);
        code = '\n<label for="status">Status (click to change status)</label>\n';
        if(Status == "Present"){
          code += '<button type="toggle" class="btn btn-danger btn-block" id="status_toggle" value="Absent">'+'Absent'+'</button>\n';
        }else{
          code += '<button type="toggle" class="btn btn-success btn-block" id="status_toggle" value="Present">'+'Present'+'</button>\n';
        }
        jquery("#status").empty();
        jquery("#status").append(code);
        console.log(Emp_ID);
        fs.writeFile(Emp_html, dom.serialize(), err => {
          console.log('status changed successfully');
        });
        res.redirect('/receptionist');
      });
  });
});

app.post('/f_used',function(req,res){
  patientID = parseInt(req.body.pid);
  arr = Object.keys(req.body);
  var i;
  for(i=0; i<arr.length; i++){
    if(arr[i]!='pid'){
      fid = parseInt(arr[i]);
      sql_q = "call insert_facility("+patientID+","+fid+");";
      console.log(sql_q);
      con.query(sql_q,
      function(err,result,fields){
    });
    }
  }
  res.redirect('/receptionist');
});

app.post('/payment',function(req,res){
  patientID = parseInt(req.body.pid);
  date = req.body.date_input;
  mode = req.body.mode;
  amt = req.body.amt;
  sql_q = "call insert_bill("+patientID+",'"+mode+"',"+amt+",'"+date+"');";
  console.log(sql_q)
  con.query(sql_q,
      function(err,result,fields){
  });
  res.redirect('/receptionist');
});
var exec = require('child_process').exec,
    child;
var fs = require('fs');
var csv = require('csv');
// child = exec('mongoimport --db admin --collection user --type csv --headerline --file ./apidata/user.csv',
//   function (error, stdout, stderr) {
//     console.log('stdout: ' + stdout);
//     console.log('stderr: ' + stderr);
//     if (error !== null) {
//       console.log('exec error: ' + error);
//     }
// })
// var myArr = [
//   "module.exports =",
//   "  schema: true",
//   "  autoCreatedAt: true",
//   "  autoUpdatedAt: false",
//   "  attributes:"];

// fs.readFile('../apidata/user.csv', {encoding: 'utf8'}, function(err, data) {
//   csv.parse(data, {rowDelimiter: '\r\n'}, function(err,json){
//     if (err) console.log('err: '+ err);
//     else console.log(json);
//   })
  // data = data.split('\n');
  // var fields = data.shift().replace(/^[\s\n]+|[\s\n]+$/g,'').split(',');
  // console.log(fields.length);
  // for (var i = 0; i < data.length; i++) {
  //   console.log(i);
  //   console.log(data[i].split(',').length);
  //   for (var j = 0; j < data[i].split(',').length; j ++) {
  //   	console.log(data[i].split(',')[j]);
  //   }
  // }
// });

// var input = '1,MEATH,MICHAEL,J,DC,M,2730 CARPENTER RD,STE 3,Ann Arbor,MI,48108,Washtenaw,,,,,,,"Life Chiropractic College (Marietta, GA)",2000,\n2,BOOMER,SANDRA,L,NP,F,3535 PARK ST,STE 110,Muskegon,MI,49444,Muskegon,,,,,,,,,';
// ;
// csv.parse(input, function(err, output){
//   console.log(output);
// });
//   var mytext = myArr.join("\n");
fs.writeFile('./input.txt', 'abc', function (err) {
	if (err) throw err;
});  
// });

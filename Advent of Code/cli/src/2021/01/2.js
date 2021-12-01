const fs = require('fs');
const { parse } = require('path');

fs.readFile('input1.txt', 'utf8' , (err, data) => {
  if (err) {
    console.error(err);
    return
  }
  let inputData = data.split("\r\n").map(number => parseInt(number));
  let measurementIncreastedCounter = 0;
  for(let i = 0; i <= inputData.length; i++){
    if(i < 3) continue;

    let lastGrp = inputData[i-3] + inputData[i-2] + inputData[i-1];
    let thisGrp = inputData[i-2] + inputData[i-1] + inputData[i];

    if(thisGrp > lastGrp){
        measurementIncreastedCounter++;
    }
  }
  console.log(measurementIncreastedCounter);
});

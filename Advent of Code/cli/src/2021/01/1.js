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
    if(i == 0) continue;

    if(inputData[i] > inputData[i-1]){
        measurementIncreastedCounter++;
    }
  }
  console.log(measurementIncreastedCounter);
});

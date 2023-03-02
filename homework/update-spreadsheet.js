const { google } = require('googleapis');
const fs = require('fs');

const privatekey = require('./arhitecturi-bot.json');
const scopes = ['https://www.googleapis.com/auth/spreadsheets'];

function getKeyByValue(object, value) {
  return Object.keys(object).find(key => object[key] === value);
}


var sheetDict = {
  "C-112A": 0,
  "C-112B": 306790469,
  "C-112C": 164198878,
  "C-112D": 951319946,
  "C-112E": 577175168,
};

executionResult = fs.readFileSync('./out/RESULT', 'utf-8')

const jwtClient = new google.auth.JWT(
  privatekey.client_email,
  null,
  privatekey.private_key,
  scopes
);

jwtClient.authorize(function(err, tokens) {
    if (err) {
      console.error(err);
      return;
    }
    const sheets = google.sheets({ version: 'v4', auth: jwtClient });

    const spreadsheetId = process.argv[2]
    const sheetId = process.argv[3]
    const cellNumber = process.argv[4]
    const newValue = process.argv[5]
    const passedColor = {
        red: 0,
        green: 1,
        blue: 0,
    };
    const failedColor = {
        red: 1,
        green: 0,
        blue: 0,
    };
    
    beforeValues = []

    sheets.spreadsheets.get({
      spreadsheetId,
      ranges: [`${getKeyByValue(sheetDict, parseInt(sheetId))}!C2:C`],
      includeGridData: true
    },  (err, res) => {
      if (err) {
        console.error(err);
        return;
      }
      sheet = res.data.sheets[0]
      values = sheet.data[0].rowData.slice(0,16)
      goodColor = (newValue >= 50) ? passedColor : failedColor
      values.forEach((row, index) => {
        existingValue = row.values[0]
        if(existingValue.hasOwnProperty('formattedValue')) {
          beforeValues.push({
            userEnteredValue: (index + 1) == cellNumber ? parseFloat(newValue).toFixed(2) : existingValue.formattedValue,
            backgroundColor: (index + 1) == cellNumber ? goodColor : existingValue.effectiveFormat.backgroundColor
          })
        }
      })


      const requests = beforeValues.map((cellObject, i) => ({
        repeatCell: {
          range: {
            sheetId,
            startRowIndex: i + 1,
            endRowIndex: i + 2,
            startColumnIndex: 2,
            endColumnIndex: 3
          },
          cell: {
            userEnteredValue: {
              stringValue: cellObject.userEnteredValue
            },
            userEnteredFormat: {
              backgroundColor: cellObject.backgroundColor
            },
            note: (i + 1) == cellNumber ? executionResult : ""
          },
          fields: 'note,userEnteredValue,userEnteredFormat.backgroundColor'
        }
      }));

      sheets.spreadsheets.batchUpdate({
        spreadsheetId,
        requestBody: { requests }
      }, (err, res) => {
        if (err) return console.error(`The API returned an error: ${err}`);
        console.log(res)
        console.log(`Updated ${res.data.totalUpdatedCells} cells in column C`);
      });

    });

    

    


});